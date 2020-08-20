provider "aws" {
  profile = var.profile
  region  = var.region
}

resource "aws_key_pair" "key_pair" {
  key_name   = "key-pair--${var.environment}"
  public_key = file("./terraform.pem")
}