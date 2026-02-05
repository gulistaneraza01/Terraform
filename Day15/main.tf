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


resource "aws_route_table" "primary_route_table" {
  provider = aws.primary
  vpc_id   = aws_vpc.primary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary_igw.id
  }

  tags = {
    Name = "Primary Route table"
  }
}

resource "aws_route_table" "secondary_route_table" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.secondary_igw.id
  }

  tags = {
    Name = "Secondary Route table"
  }
}


resource "aws_route_table_association" "primary_route_table_ass" {
  provider = aws.primary

  subnet_id      = aws_subnet.primary_subnet.id
  route_table_id = aws_route_table.primary_route_table.id
}

resource "aws_route_table_association" "secondary_route_table_ass" {
  provider = aws.secondary

  subnet_id      = aws_subnet.secondary_subnet.id
  route_table_id = aws_route_table.secondary_route_table.id
}

resource "aws_vpc_peering_connection" "primary_to_secondary" {
  provider    = aws.primary
  peer_vpc_id = aws_vpc.secondary_vpc.id
  vpc_id      = aws_vpc.primary_vpc.id
  peer_region = var.secondary_region
  auto_accept = false

  tags = {
    Name = "Primary-To-Secondary-Peering"
  }
}


resource "aws_vpc_peering_connection" "secondary_to_primary" {
  provider    = aws.secondary
  peer_vpc_id = aws_vpc.primary_vpc.id
  vpc_id      = aws_vpc.secondary_vpc.id
  peer_region = var.primary_region
  auto_accept = false

  tags = {
    Name = "Secondary-To-Primary-Peering"
  }
}

resource "aws_route" "route-p-to-s" {
  provider = aws.primary

  route_table_id            = aws_route_table.primary_route_table.id
  destination_cidr_block    = var.secondary_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary_acceptor]
}

resource "aws_route" "route-s-to-p" {
  provider = aws.secondary

  route_table_id            = aws_route_table.secondary_route_table.id
  destination_cidr_block    = var.primary_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.secondary_to_primary.id

  depends_on = [aws_vpc_peering_connection_accepter.primary_acceptor]
}
