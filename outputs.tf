# output "public_ip" {
#     value = aws_instance.webserver.public_ip
# }

# output "ssh_command" {
#     value = "ssh -i ./terraform.pem ec2-user@${aws_eip.ip.public_ip}"
# }