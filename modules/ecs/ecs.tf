resource "aws_ecs_cluster" "ecs_cluster" {
  name               =  "CLUSTER-${var.environment}"
  capacity_providers = [aws_ecs_capacity_provider.capacity_provider.name]
  tags = {
    "env" = "${var.environment}"
  }
}

resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = "capacity-provider-${var.environment}"
  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.auto_scaling_group_arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 85
    }
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "backend-${var.environment}"
  container_definitions = file("ecs_tasks.json")
  network_mode          = "bridge"
  tags = {
    "env" = "${var.environment}"
  }
}

resource "aws_ecs_service" "ecs_service" {
  name            = "web-service-${var.environment}"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.containers_desired_count
  health_check_grace_period_seconds = 30
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "backend-${var.environment}"
    container_port   = 80
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count]
  }
  launch_type = "EC2"
  depends_on  = [var.depends]
}

resource "aws_cloudwatch_log_group" "cloud_log_group" {
  name = "/ecs/backend-container-${var.environment}"
  tags = {
    "env" = "${var.environment}"
  }
}