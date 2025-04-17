environment      = "dev"
region         = "us-east-2" # Ohio
cluster_name   = "jm-ecs-cluster-dev"

allowed_ips    = ["0.0.0.0/0"] # permitir acceso público (puedes limitar esto luego)

# Asegúrate de incluir también estos valores según tus módulos:
vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
isolated_subnets = ["10.0.5.0/24"]
availability_zones   = ["us-east-2a", "us-east-2b"]

// configuraciones de las apps
app1_name         = "jm-ecs-app1-dev"
app2_name         = "jm-ecs-app2-dev"
app1_image_url    = "nginx:latest"
app2_image_url    = "httpd:latest"