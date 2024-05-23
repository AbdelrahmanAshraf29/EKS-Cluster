provider "aws" {
  region = "us-west-1" 
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "EKS-Cluster" 
  cluster_version = "1.21" 

  # The role ARN for the EKS cluster
  cluster_role_arn = "arn:aws:iam::123456789012:role/EKSClusterRole" 

  # VPC configuration
  vpc_id     = "vpc-0abcd1234efgh5678" 
  subnet_ids = ["subnet-0abc1234def567890", "subnet-0abc1234def567891"] 

  # Node Group configuration
  node_groups = {
    my_node_group = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.medium"

      key_name = "my-key-pair" 

      tags = {
        Name = "my-node-group"
      }
    }
  }
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "kubeconfig" {
  value = module.eks.kubeconfig
  sensitive = true
}
