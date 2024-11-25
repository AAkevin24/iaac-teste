resource "aws_vpc" "new-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "${var.prefix}-vpc"
    }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnets" {
  count = 2
  availability_zone = data.aws_availability_zones.available.names[count.index] 
  vpc_id     = aws_vpc.new-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}Subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "new-igw" {
  vpc_id = aws_vpc.new-vpc.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "new-rt" {
  vpc_id = aws_vpc.new-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new-igw.id
  }

  tags = {
    Name = "${var.prefix}-rt"
  }
}

resource "aws_route_table_association" "new-rt-aws_route_table_association" {
  count = 2 
  subnet_id      = aws_subnet.subnets.*.id[count.index]
  route_table_id = aws_route_table.new-rt.id
}

