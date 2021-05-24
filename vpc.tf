#Create VPC
resource "aws_vpc" "MongoElastic" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "MongoElastic"
    Environment = "ElasticSearch"
  }
}

#Create Subnet (public and private to launch instance into that)
#Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.MongoElastic.id
  cidr_block = "10.0.0.0/22"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public subnet"
    Environment = "ElasticSearch"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.MongoElastic.id
  cidr_block = "10.0.4.0/22"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public subnet"
    Environment = "ElasticSearch"
  }
}

#create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.MongoElastic.id

  tags = {
    Name = "igw"
  }
}

#route table for subnets
#create public route table and define igw route
resource "aws_route_table" "public_route_table"{
  vpc_id = aws_vpc.MongoElastic.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

# Associate public subnet to public route table
resource "aws_route_table_association" "public_table_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create Nat_Gateway and add route to privae table


