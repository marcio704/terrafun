resource "aws_launch_configuration" "lc" {
  name                 = "ecs-${var.environment}"
  image_id             = data.aws_ami.amazon_linux.id
  instance_type        = var.ec2_type
  iam_instance_profile = aws_iam_instance_profile.ecs_service_role.name

  lifecycle {
    create_before_destroy = true
  }
  key_name                    = aws_key_pair.key_pair.key_name
  security_groups             = [
    aws_security_group.http_security_group.id,
    aws_security_group.ssh_security_group.id,
  ]
  associate_public_ip_address = true
  user_data                   = <<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=CLUSTER-${var.environment}" >> /etc/ecs/ecs.config
EOF
}

resource "aws_autoscaling_group" "asg" {
  name                      = "asg-${var.environment}"
  launch_configuration      = aws_launch_configuration.lc.name
  min_size                  = var.ec2_min_size
  max_size                  = var.ec2_max_size
  desired_capacity          = var.ec2_desired
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = module.vpc.public_subnets

  target_group_arns     = [aws_lb_target_group.lb_target_group.arn]
  protect_from_scale_in = true
  lifecycle {
    create_before_destroy = true
  }
}