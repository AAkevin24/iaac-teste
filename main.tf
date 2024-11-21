module "vpc" {
    source = "./modules/vpc"
    prefix = var.prefix
}

module "eks" {
    source = "./modules/eks"
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.subnet_ids
    prefix = var.prefix
    min_size = var.min_size
    max_size = var.max_size
    desired_size = var.desired_size
}