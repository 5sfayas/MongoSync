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
