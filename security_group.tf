resource "aws_security_group" "http_security_group" {
  name        = "http_security_group"
  description = "Allow HTTP inbound traffic (TerraForm)"
  vpc_id = module.vpc.vpc_id
    
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

resource "aws_security_group" "ssh_security_group" {
  name        = "ssh_security_group"
  description = "Allow SSH inbound traffic (TerraForm)"
  vpc_id = module.vpc.vpc_id
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}