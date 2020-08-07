
resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Dev VPC"
  }
}

resource "aws_subnet" "subnet_public_dev" {
  availability_zone_id = "usw2-az1"
  cidr_block           = "10.0.0.0/24"
  vpc_id = aws_vpc.dev_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet Public DEV (Terraform)"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_vpc.id
}

resource "aws_route_table" "allow_outgoing_access" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route Table Public Dev (Terraform)"
  }
}

resource "aws_route_table_association" "route_subnet_public_association" {
  subnet_id      = aws_subnet.subnet_public_dev.id
  route_table_id = aws_route_table.allow_outgoing_access.id
}


resource "aws_eip" "ip" {
  instance = aws_instance.webserver.id
  depends_on = [aws_vpc.dev_vpc]
}