region          = "us-east-1"
vpc_cidr        = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
isolated_subnets = ["10.0.5.0/24", "10.0.6.0/24"]

app1_name  = "jm-test-app"
app2_name  = "jm-test-app2"
app1_image_url = "nginx:latest"
app2_image_url = "httpd:latest"
