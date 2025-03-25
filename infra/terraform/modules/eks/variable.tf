variable "cluster_name" {
  type = string
}

variable "k8s_version" {
  type    = string
  default = "1.32"
}

variable "subnet_ids" {
  type = list(string)
}