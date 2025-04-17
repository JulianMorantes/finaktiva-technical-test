environment      = "stg"
region         = "us-east-2" # Ohio
cluster_name   = "jm-ecs-cluster-stg"

allowed_ips    = ["0.0.0.0/0"] # permitir acceso público (puedes limitar esto luego)

vpc_cidr = "10.1.0.0/16"
public_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnets = ["10.1.3.0/24", "10.1.4.0/24"]
isolated_subnets = ["10.0.5.0/24"]
availability_zones   =  ["us-west-2a", "us-west-2b"]

// configuraciones de las apps
app1_name         = "jm-ecs-app1-stg"
app2_name         = "jm-ecs-app2-stg"
app1_image_url    = "nginx:latest"
app2_image_url    = "httpd:latest"