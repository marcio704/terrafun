
variable "ec2_type" {
  default = "t2.micro"
}

variable "ec2_min_size" {
  default = 1
}

variable "ec2_max_size" {
  default = 1
}

variable "ec2_desired" {
  default = 1
}

variable "zone_id" {
  default = "Z09701852R6BMHK2XHRQ"
}


# dynamic input if not exists a .tfvars defined

variable "environment" {}
variable "public_subnets" {}
variable "vpc_id" {}
variable "iam_instance_profile" {}
variable "domain_name" {}
variable "key_name" {}
