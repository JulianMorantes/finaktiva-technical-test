// main.tf

provider "aws" {
  region = var.region
}

module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  isolated_subnets = var.isolated_subnets
}

module "alb" {
  source = "./modules/alb"  # Asumiendo que el ALB está definido en ./modules/alb
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnet_ids  # Asegúrate de pasar las subredes públicas
}

module "ecr_app1" {
  source = "./modules/ecr" # Asumiendo que el ECR está definido en ./modules/ecr
  name   = "${var.app1_name}-repo"
  tags = {
    Environment = var.environment
    App         = var.app1_name
  }
}

module "ecr_app2" {
  source = "./modules/ecr"
  name   = "${var.app2_name}-repo"
  tags = {
    Environment = var.environment
    App         = var.app2_name
  }
}

module "ecs" {
  source = "./modules/ecs" # Asumiendo que el ECR está definido en ./modules/ecr
  cluster_name           = "demo-cluster"  # Nombre del ECS cluster
  app1_image             = var.app1_image_url
  app2_image             = var.app2_image_url
  private_subnet_ids     = module.vpc.private_subnet_ids
  public_subnet_ids      = module.vpc.public_subnet_ids // Configuraciones para Ip publica y acceso a inter 
  security_group_id      = module.alb.security_group_id  # Asumiendo que tienes un ALB con su SG
}


data "aws_availability_zones" "available" {}