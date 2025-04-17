variable "name" {
  description = "Nombre del repositorio ECR"
  type        = string
}

variable "tags" {
  description = "Etiquetas aplicadas al repositorio"
  type        = map(string)
  default     = {}
}