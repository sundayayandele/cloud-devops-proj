# Create VPC
resource "aws_vpc" "cloudevopsvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = "${var.environment}"
  }
}

# Configure Private Subnet for Default Region
resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.cloudevopsvpc.id
  availability_zone       = "${var.region}a"
  cidr_block              = var.private_subnet1_cidr
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-private-subnet1"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.cloudevopsvpc.id
  availability_zone       = "${var.region}b"
  cidr_block              = var.private_subnet2_cidr
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-private-subnet2"
    Environment = "${var.environment}"
  }
}

#Routing table for private subnet for Default Region

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.cloudevopsvpc.id
  tags = {
    Name        = "${var.environment}-private-route-table"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "private1" {

  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {

  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private.id
}

#Internet GW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cloudevopsvpc.id
  tags = {
    Name        = "${var.environment}-igw"
    Environment = "${var.environment}"
  }
}