output "auto_scaling_group_arn" {
    value = "${aws_autoscaling_group.asg.arn}"
}

output "target_group_arn" {
    value = "${aws_lb_target_group.lb_target_group.arn}"
}

output "lb_listener" {
    value = "${aws_lb_listener.lb_listener}"
}