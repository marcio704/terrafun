variable "region" {
  default = "us-west-2"
}

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

variable "containers_desired_count" {
  default = 2
}

variable "available_zones" {
    type    = list
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

# dynamic input if not exists a .tfvars defined

variable "environment" {}
variable "profile" {}
variable "domain_name" {}
