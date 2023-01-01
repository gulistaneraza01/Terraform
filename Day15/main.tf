resource "aws_vpc" "primary_vpc" {
  cidr_block = var.primary_cidr
  provider   = aws.primary

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Primary VPC"
  }
}

resource "aws_vpc" "secondary_vpc" {
  cidr_block = var.secondary_cidr
  provider   = aws.secondary

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Secondary VPC"
  }
}

resource "aws_subnet" "primary_subnet" {
  provider   = aws.primary
  vpc_id     = aws_vpc.primary_vpc.id
  cidr_block = var.primary_cidr

  availability_zone       = data.aws_availability_zones.primary.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Primary Subnet"
  }
}

resource "aws_subnet" "secondary_subnet" {
  provider   = aws.secondary
  vpc_id     = aws_vpc.secondary_vpc.id
  cidr_block = var.secondary_cidr

  availability_zone       = data.aws_availability_zones.secondary.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Secondary Subnet"
  }
}

resource "aws_internet_gateway" "primary_igw" {
  provider = aws.primary
  vpc_id   = aws_vpc.primary_vpc.id

  tags = {
    Name = "Primary IGW"
  }
}

resource "aws_internet_gateway" "secondary_igw" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary_vpc.id

  tags = {
    Name = "Secondary IGW"
  }
}
