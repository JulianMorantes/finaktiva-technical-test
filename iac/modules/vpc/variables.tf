variable "vpc_cidr" {
  description = "CIDR block de la VPC"
  type        = string
}

variable "public_subnets" {
  description = "CIDRs de subredes públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDRs de subredes privadas"
  type        = list(string)
}

variable "isolated_subnets" {
  description = "CIDRs de subredes aisladas"
  type        = list(string)
}
