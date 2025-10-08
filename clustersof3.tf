module "eks_cluster_1" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "cluster-1"
  cluster_version = "1.28"
  subnets         = ["subnet-1", "subnet-2"]
  vpc_id          = "vpc-xxxxxx"
  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]
    }
  }
}

module "eks_cluster_2" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "cluster-2"
  cluster_version = "1.28"
  subnets         = ["subnet-3", "subnet-4"]
  vpc_id          = "vpc-yyyyyy"
  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]
    }
  }
}

module "eks_cluster_3" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "cluster-3"
  cluster_version = "1.28"
  subnets         = ["subnet-5", "subnet-6"]
  vpc_id          = "vpc-zzzzzz"
  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]
    }
  }
}

Same configuration for all 3 clusters, deployed in different VPCs (or subnets)


├── outputs.tf
main.tf
hcl
Copy code
provider "aws" {
  region = "us-west-2"
}

# Loop over 3 clusters
module "eks_clusters" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  for_each = {
    cluster1 = "10.0.0.0/16"
    cluster2 = "10.1.0.0/16"
    cluster3 = "10.2.0.0/16"
  }

  cluster_name    = each.key
  cluster_version = "1.28"

  vpc_id     = module.vpc[each.key].vpc_id
  subnet_ids = module.vpc[each.key].private_subnets

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      min_capacity     = 1
      max_capacity     = 3

      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Environment = "dev"
    Cluster     = each.key
  }
}

# VPCs per cluster
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  for_each = {
    cluster1 = "10.0.0.0/16"
    cluster2 = "10.1.0.0/16"
    cluster3 = "10.2.0.0/16"
  }

  name = "${each.key}-vpc"
  cidr = each.value

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["${cidrsubnet(each.value, 8, 1)}", "${cidrsubnet(each.value, 8, 2)}"]
  public_subnets  = ["${cidrsubnet(each.value, 8, 3)}", "${cidrsubnet(each.value, 8, 4)}"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "dev"
    VPC         = each.key
  }
}

