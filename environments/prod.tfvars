environment    = "prod"
region         = "us-east-1" # Virginia
cluster_name   = "jm-ecs-cluster-pdn"

allowed_ips    = ["0.0.0.0/0"] # permitir acceso público (puedes limitar esto luego)

vpc_cidr = "10.2.0.0/16"
public_subnets = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnets = ["10.2.3.0/24", "10.2.4.0/24"]
isolated_subnets = ["10.0.5.0/24"]
availability_zones   =  ["us-east-1a", "us-east-1b"]

// configuraciones de las apps
app1_name         = "jm-ecs-app1-pdn"
app2_name         = "jm-ecs-app2-pdn"
app1_image_url    = "nginx:latest"
app2_image_url    = "httpd:latest"