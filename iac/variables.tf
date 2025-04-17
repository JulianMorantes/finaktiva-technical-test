variable "region" {
  description = "Región AWS"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Deployment environment (dev, stg, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
}

variable "public_subnets" {
  description = "Lista de CIDRs para subredes públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de CIDRs para subredes privadas"
  type        = list(string)
}

variable "isolated_subnets" {
  description = "Lista de CIDRs para subredes aisladas"
  type        = list(string)
}

variable "app1_name" {
  description = "Nombre de la primera aplicación"
  type        = string
}

variable "app2_name" {
  description = "Nombre de la segunda aplicación"
  type        = string
}

variable "app1_image_url" {
  description = "Imagen de Docker para la aplicación 1"
  type        = string
}

variable "app2_image_url" {
  description = "Imagen de Docker para la aplicación 2"
  type        = string
}
