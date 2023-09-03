module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = "techoutcomes"
  cluster_version = "1.23"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  enable_irsa = true

  eks_managed_node_group_defaults = {
    disk_size = 50
  }

  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 5

      labels = {
        role = "general"
      }

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }

    spot = {
      desired_size = 1
      min_size     = 1
      max_size     = 5

      labels = {
        role = "spot"
      }

      taints = [{
        key    = "market"
        value  = "spot"
        effect = "NO_SCHEDULE"
      }]

      instance_types = ["t3.micro"]
      capacity_type  = "SPOT"
    }
  }



  manage_aws_auth_configmap = true
  aws_auth_roles = [
    {
      rolearn  = module.eks_admins_iam_role.iam_role_arn
      username = module.eks_admins_iam_role.iam_role_name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::777595570545:role/eks-admin"
      username = "estherdagk8s"
      groups   = ["system:masters"]
    },
  ]
  aws_auth_users = [
      {
        userarn  = "arn:aws:iam::777595570545:user/eksadmin"
        username = "eksadmin"
        groups   = ["system:masters"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/ekstestuser"
        username = "ekstestuser"
        groups   = ["ekstestuser"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/moules"
        username = "moules"
        groups   = ["moules"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/estherdag"
        username = "estherdagk8s"
        groups   = ["estherdag"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/sunny"
        username = "sunny"
        groups   = ["sunny"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/emmanuella"
        username = "emmanuella"
        groups   = ["emmanuella"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/arsene"
        username = "arsene"
        groups   = ["arsene"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/madam"
        username = "madam"
        groups   = ["madam"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/derick"
        username = "derick"
        groups   = ["derick"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/anis"
        username = "anis"
        groups   = ["anis"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/zoh"
        username = "zoh"
        groups   = ["zoh"]
      },
      {
        userarn  = "arn:aws:iam::777595570545:user/christiana"
        username = "christiana"
        groups   = ["christiana"]
      },
    ]


  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
  }

  tags = {
    Environment = "staging"
  }
}

# https://github.com/terraform-aws-modules/terraform-aws-eks/issues/2009
data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  # token                  = data.aws_eks_cluster_auth.default.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
    command     = "aws"
  }
}
