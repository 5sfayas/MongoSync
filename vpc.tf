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
# before create elastic ip and assoicae the ip to nat gateway
resource "aws_eip" "nat_eip" {
  vpc = true
  depends_on = [aws_internet_gateway.igw]  
}

resource "aws_nat_gateway" "nat_geteway" {
  allocation_id = aws_eip.nat_eip.allocation_id
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "nat_geteway"
    Environment = "ElasticSearch"
  }
}

#create Private Subnet and Associal Nat
resource "aws_route_table" "private_table" {
  vpc_id = aws_vpc.MongoElastic.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_geteway.id 
  }
} 

#associate Private subnet to private table
resource "aws_route_table_association" "private_table_association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_table.id
}

#Lets Create VPC peering from mongo db and 

