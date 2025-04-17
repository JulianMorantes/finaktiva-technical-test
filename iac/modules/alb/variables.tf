variable "vpc_id" {
  type        = string
  description = "ID de la VPC"
}

variable "subnets" {
  type        = list(string)
  description = "Subredes donde el ALB se desplegará"
}
