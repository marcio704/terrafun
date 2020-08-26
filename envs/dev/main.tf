provider "aws" {
  profile = var.profile
  region  = var.region
}

resource "aws_key_pair" "key_pair" {
  key_name   = "key-pair-${var.environment}"
  public_key = file("./terraform.pem")
}

module "vpc_main" {
  source = "../../modules/vpc"
  environment = "dev"
}

module "ec2_main" {
  source = "../../modules/ec2"
  environment = "dev"
  domain_name = "dev.timeliest.xyz"
  public_subnets = module.vpc_main.public_subnets
  vpc_id = module.vpc_main.vpc_id
  iam_instance_profile = module.ecs_main.iam_instance_profile # belongs to ec2 :) TODO move
  key_name = aws_key_pair.key_pair.key_name
}

module "ecs_main" {
  source = "../../modules/ecs"
  environment = "dev"
  auto_scaling_group_arn = module.ec2_main.auto_scaling_group_arn
  target_group_arn = module.ec2_main.target_group_arn
  depends = [module.ec2_main.lb_listener]
}