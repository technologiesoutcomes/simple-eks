module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "main"
  cidr = "10.10.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.10.0.0/19", "10.10.32.0/19"]
  public_subnets  = ["10.10.64.0/19", "10.10.96.0/19"]

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false
  map_public_ip_on_launch = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = "staging"
  }
}
