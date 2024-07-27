# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id        = aws_default_vpc.default.id
  count         = length(data.aws_availability_zones.available_zones.names)
  cidr_block    = var.cidr[count.index]              #  "172.31.${100 + count.index}.0/24" 
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project_name}-private_subnet-${data.aws_availability_zones.available_zones.names[count.index]}"
  }
}

# Fetch the default public subnets
data "aws_subnets" "default_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

resource "aws_eip" "elastic_ip" {
  tags = {
    Name = "${var.project_name}-Elastic_ip"
    }
}

# Nat Gateway for private subnets 
resource "aws_nat_gateway" "public_subnet_NGW" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = data.aws_subnets.default_public_subnets.ids[0]
  depends_on = [ aws_eip.elastic_ip ]

  tags = {
    Name = "${var.project_name}-NGW"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_default_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_subnet_NGW.id
  }

  tags = {
    Name = "${var.project_name}-private-route-table"
  }
}

resource "aws_route_table_association" "private_subnets_rt_association" {
  count = length(aws_subnet.private_subnets)  
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id  
}