resource "azurerm_resource_group" "example" {
provider "aws" {
  region = "us-west-2"
}

locals {
  clusters = {
    cluster1 = {
      cidr_block = "10.0.0.0/16"
    }
    cluster2 = {
      cidr_block = "10.1.0.0/16"
    }
    cluster3 = {
      cidr_block = "10.2.0.0/16"
    }
  }
}

# Create one VPC per cluster
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  for_each = local.clusters

  name = "${each.key}-vpc"
  cidr = each.value.cidr_block

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["${cidrsubnet(each.value.cidr_block, 8, 1)}", "${cidrsubnet(each.value.cidr_block, 8, 2)}"]
  public_subnets  = ["${cidrsubnet(each.value.cidr_block, 8, 3)}", "${cidrsubnet(each.value.cidr_block, 8, 4)}"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "dev"
    Cluster     = each.key
  }
}

# Create one EKS cluster per VPC
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  for_each = local.clusters

  cluster_name    = each.key
  cluster_version = "1.28"

  subnet_ids = module.vpc[each.key].private_subnets
  vpc_id     = module.vpc[each.key].vpc_id

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Environment = "dev"
    Cluster     = each.key
  }
}
