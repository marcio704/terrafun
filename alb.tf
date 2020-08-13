resource "aws_lb" "ecs_lb" {
  name               = "test-ecs-lb"
  load_balancer_type = "application"
  internal           = false
  subnets            = module.vpc.public_subnets
  
  tags = {
    "env"       = "dev"
  }
  security_groups = [
    aws_security_group.http_security_group.id,
    aws_security_group.ssh_security_group.id,
  ]
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "tf-lb-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 10
    interval            = 30
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}