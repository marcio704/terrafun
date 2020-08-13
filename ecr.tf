resource "aws_ecr_repository" "image_repository" {
  name                 = "terra_images"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    "env"       = "dev"
  }
}
