




provider "aws" {
  region = "us-west-2"
}

locals {
  clusters = {
    cluster1 = {
      cidr_block     = "10.0.0.0/16"
      cluster_version = "1.28"
    }
    cluster2 = {
      cidr_block     = "10.1.0.0/16"
      cluster_version = "1.28"
    }
    cluster3 = {
      cidr_block     = "10.2.0.0/16"
      cluster_version = "1.28"
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
    Cluster = each.key
  }
}

# Create EKS clusters using for_each
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  for_each = local.clusters

  cluster_name    = each.key
  cluster_version = each.value.cluster_version

  vpc_id     = module.vpc[each.key].vpc_id
  subnet_ids = module.vpc[each.key].private_subnets

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
