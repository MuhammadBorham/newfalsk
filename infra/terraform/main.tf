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