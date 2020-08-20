module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "2.38.0"
  name           = "ecs-provisioning-${var.environment}"
  cidr           = "10.0.0.0/16"
  azs            = var.available_zones
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  tags = {
    "env"       = "${var.environment}"
  }

}

data "aws_vpc" "main" {
  id   = module.vpc.vpc_id
}