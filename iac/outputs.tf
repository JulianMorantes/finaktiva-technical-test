output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}

# output "ecr_app1_url" {
#   value = module.ecr.app1_repo_url
# }

# output "ecr_app2_url" {
#   value = module.ecr.app2_repo_url
# }

# output "ecs_cluster_name" {
#   value = module.ecs.cluster_name
# }

