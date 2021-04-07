#Create VPC 
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

#Create IGW 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "IGW"
  }
}


#Create subnet 
resource "aws_subnet" "subnet_1" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "my-subnet"
  }
}

#Create a route table
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "My-RT"
  }
}

#Associate subnet with Route table
resource "aws_route_table_association" "assoc" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.my-route-table.id
}

