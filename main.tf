provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_security_group" "dummy_sg" {
  name        = "dummy-sec-gr"
  description = "Allow SSH inbound traffic (TerraForm)"
  vpc_id = aws_vpc.dummy_vpc.id
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_key_pair" "dummy" {
  key_name   = "dummy-key"
  public_key = file("./terraform.pem")
}

resource "aws_instance" "dummy" {
  key_name      = aws_key_pair.dummy.key_name
  ami           = "ami-067f5c3d5a99edc80"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.subnet_dummy_public.id

  vpc_security_group_ids = [
    aws_security_group.dummy_sg.id,
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./terraform.key")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.dummy.public_ip} > ip_address.txt"
  }
}
