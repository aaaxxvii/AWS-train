# VPC
resource "aws_vpc" "gemini-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "gemini-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.gemini-vpc.id
}

# Public Subnet
resource "aws_subnet" "public-1a" {
  vpc_id     = aws_vpc.gemini-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "gemini-public-subnet-1a"
  }
}

resource "aws_subnet" "public-1c" {
  vpc_id     = aws_vpc.gemini-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-1c"


  tags = {
    Name = "gemini-public-subnet-1c"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.gemini-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "gemini-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-1c" {
  subnet_id      = aws_subnet.public-1c.id
  route_table_id = aws_route_table.public.id
}