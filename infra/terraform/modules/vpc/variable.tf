variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "env" {
  type    = string
  default = "prod"
}

variable "cluster_name" {
  type = string
}