variable "aws_region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  default = "10.0.0.0/20"
}

variable "public_subnet_b_cidr" {
  default = "10.0.16.0/20"
}

variable "public_subnet_c_cidr" {
  default = "10.0.32.0/20"
}

variable "db_password" {
  description = "Password for the MYSQL admin user"
  sensitive   = true
}


