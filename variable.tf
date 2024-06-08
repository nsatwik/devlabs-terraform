# Variable for region
variable "region" {
    default = "ap-south-1" 
}

# Variable for ami
variable "ami" {
  default = "ami-05e00961530ae1b55"
}

# Variable for vpc
variable "vpc" {
  default = "demo-vpc"
}

# Variable for instance_type
variable "instance_type" {
  default = "t2.micro"
}

# Variable for key_pair
variable "key_name" {
  default = "k8s-key"
}

# Variable for cidr_block
variable "cidr_block" {
  default = "10.0.0.0/16"
}

# Varible for subnet_cidr_block
variable "subnet_cidr_block" {
  default = "10.0.1.0/24"
}

# Variable for availability_zone
variable "availability_zone" {
  default = "ap-south-1a"
}

# Variable for aws_route_table__cidr_block
variable "aws_route_table__cidr_block" {
  default = "0.0.0.0/0"
}