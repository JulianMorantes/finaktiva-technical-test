
// Gener el ECS Clouster resource.
resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

//construccion de rol y permisos en iam
resource "aws_iam_role" "ecs_task_execution" {
  name = "${var.cluster_name}-ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

// genera una politica para el  rol creado previamente
resource "aws_iam_role_policy_attachment" "ecs_execution_attach" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_ecr_access" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

//define los recursos que se utilizaran en la app 1
resource "aws_ecs_task_definition" "app1" {
  family                   = "${var.cluster_name}-app1"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256" #0.25 vCPU (valor en CPU units)
  memory                   = "512" # 0.5 GB de memoria (en MB)
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "jm-app1"
      image     = var.app1_image
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "app2" {
  family                   = "${var.cluster_name}-app2"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256" #0.25 vCPU (valor en CPU units)
  memory                   = "512" # 0.5 GB de memoria (en MB)
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "jm-app2"
      image     = var.app2_image
      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app1" {
  name            = "${var.cluster_name}-app1"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app1.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets         =  var.public_subnet_ids  //Se puede cambiar a la subnet publicas para que tengan salida a internet 
    security_groups = [var.security_group_id]
    assign_public_ip = true    //asigna un ip publica al servicio de ser necesario
  }
}

resource "aws_ecs_service" "app2" {
  name            = "${var.cluster_name}-app2"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app2.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets         = var.private_subnet_ids   //Se puede cambiar a la subnet publicas para que tengan salida a internet 
    security_groups = [var.security_group_id]
    assign_public_ip = false    //asigna un ip publica al servicio de ser necesario
  }
}
