provider "aws" {
    region = var.region
}
# Create a VPC
resource "aws_vpc" "demo-vpc" {
    tags = {
      Name = var.vpc
    }
  cidr_block = var.cidr_block
}

# Create a subnet
resource "aws_subnet" "demo-subnet" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = var.subnet_cidr_block
    
    tags = {
        Name = "demo-subnet"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-igw"
  }
}

# Create Route-Table
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  
  route {
    cidr_block = var.aws_route_table__cidr_block
    gateway_id = aws_internet_gateway.demo-igw.id
  } 

  tags = {
    Name = "demo-rt"
  }
}

# Create Route-Table Association
resource "aws_route_table_association" "demo-rt-association" {
  subnet_id = aws_subnet.demo-subnet.id
  route_table_id = aws_route_table.demo-rt.id
}

# Create Security Groups
resource "aws_security_group" "demo-sg" {
  name = "demo-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-sg"
  }

  ingress {
    from_port           = 22
    to_port             = 22
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
    ipv6_cidr_blocks    = ["::/0"]
    }

 egress {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
    ipv6_cidr_blocks    = ["::/0"]
 }
  }

# Launch EC2-instance
resource "aws_instance" "terraform-ec2" {
  tags = {
    Name = "terraform-ec2"
  }
  ami                           = var.ami  #Ubuntu-22.04
  key_name                      = var.key_name #PEM-File
  instance_type                 = var.instance_type
  subnet_id                     = aws_subnet.demo-subnet.id
  vpc_security_group_ids        = [aws_security_group.demo-sg.id]
  associate_public_ip_address   = true
}


