#VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "hammerdb-vpc"
  }
}

# Subnets
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "hammerdb-public-a"
  }
} 
resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_b_cidr
  availability_zone = "${var.aws_region}b"
  map_public_ip_on_launch = true
  tags = {
    Name = "hammerdb-public-b"
  }
}
resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_c_cidr
  availability_zone = "${var.aws_region}c"
  map_public_ip_on_launch = true
  tags = {
    Name = "hammerdb-public-c"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "hammerdb-igw"
  }
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "hammerdb-public-rt"
  }
}


#Associate Subnets with Route Table
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public_rt.id
}