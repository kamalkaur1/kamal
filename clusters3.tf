locals {
  clusters = {
    cluster1 = {
      cidr_block     = "10.0.0.0/16"
      instance_type  = "t3.medium"
      cluster_version = "1.28"
    }
    cluster2 = {
      cidr_block     = "10.1.0.0/16"
      instance_type  = "t3.large"
      cluster_version = "1.28"
    }
    cluster3 = {
      cidr_block     = "10.2.0.0/16"
      instance_type  = "t3.medium"
      cluster_version = "1.27"
    }
  }
}


