
resource "aws_vpc" "dummy_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Dummy VPC"
  }
}

resource "aws_subnet" "subnet_dummy_public" {
  availability_zone_id = "usw2-az1"
  cidr_block           = "10.0.0.0/24"
  vpc_id = aws_vpc.dummy_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet Public ( Terraform)"
  }
}

resource "aws_internet_gateway" "dummy_igw" {
  vpc_id = aws_vpc.dummy_vpc.id
}

resource "aws_route_table" "allow_outgoing_access" {
  vpc_id = aws_vpc.dummy_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dummy_igw.id
  }

  tags = {
    Name = "Route Table Public (Dummy Terraform)"
  }
}

resource "aws_route_table_association" "route_subnet_public_association" {
  subnet_id      = aws_subnet.subnet_dummy_public.id
  route_table_id = aws_route_table.allow_outgoing_access.id
}


resource "aws_eip" "ip" {
  instance = aws_instance.dummy.id
}