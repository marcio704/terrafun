variable "containers_desired_count" {
  default = 2
}
variable "environment" {}
variable "auto_scaling_group_arn" {}
variable "target_group_arn" {}
variable "depends" {}