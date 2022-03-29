variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "name" {
  type    = string
  default = "web-app-vpc"
}

variable "env" {
  type    = string
  default = "test"
}

variable "public_subnets_cidr" {
  type    = list(string)
  default = ["10.10.0.0/24", "10.10.1.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets_cidr" {
  type    = list(string)
  default = ["10.10.3.0/24", "10.10.4.0/24"]
}

variable "key_name" {
  default = "ec2-devops-code-key"
}
