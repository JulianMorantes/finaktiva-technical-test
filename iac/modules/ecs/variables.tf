variable "cluster_name" {
  type        = string
  description = "Nombre del ECS cluster"
}

variable "app1_image" {
  type        = string
  description = "Imagen de la App 1"
}

variable "app2_image" {
  type        = string
  description = "Imagen de la App 2"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Subredes privadas para los servicios ECS"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Lista de IDs de las subredes públicas"
}

variable "security_group_id" {
  type        = string
  description = "Security Group para los servicios ECS"
}
