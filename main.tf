provider "aws" {
  profile = "studies"
  region  = "us-west-2"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "key_pair_terraform"
  public_key = file("./terraform.pem")
}

# resource "aws_instance" "webserver" {
#   key_name      = aws_key_pair.key_pair.key_name
#   ami           = "ami-0873b46c45c11058d"
#   instance_type = "t2.micro"

#   subnet_id = aws_subnet.subnet_public_dev.id

#   vpc_security_group_ids = [
#     aws_security_group.http_security_group.id,
#     aws_security_group.ssh_security_group.id,
#   ]

#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = file("./terraform.key")
#     host        = self.public_ip
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo amazon-linux-extras enable nginx1.12",
#       "sudo yum -y install nginx",
#       "sudo systemctl start nginx"
#     ]
#   }

#   provisioner "local-exec" {
#     command = "echo ${self.public_ip} > ip_address.txt"
#   }
# }
