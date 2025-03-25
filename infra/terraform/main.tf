provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA2KX4BMVVG3R5KO6G"
  secret_key = "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"
}
module "vpc" {
  source       = "./modules/vpc"
  cluster_name = var.cluster_name
  region       = var.region
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = var.cluster_name
  subnet_ids   = module.vpc.public_subnet_ids
  k8s_version  = "1.32"
}