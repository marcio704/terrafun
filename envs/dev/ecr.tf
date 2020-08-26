resource "aws_ecr_repository" "images_repository" {
  name                 = "backend-${var.environment}"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    "env"       = "${var.environment}"
  }
}
