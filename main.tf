terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = "eu-west-2"
}

variable "cidr_blocks" {
    description = "The CIDR block for the VPC and subnets"
    type = list(string)
}

variable "environment" {
    description = "Deployment environment"
}

resource "aws_vpc" "dev-vpc" {
    cidr_block = var.cidr_blocks[0]

    tags = {
        Name: "dev-vpc"
        vpc_env: var.environment
    }
}

resource "aws_subnet" "dev-pub-subnet" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = var.cidr_blocks[1]
    availability_zone = "eu-west-2a"

    tags = {
        Name: "dev-pub-subnet"
        subnet_env: var.environment
    }
}

output "dev-vpc-id" {
    value = aws_vpc.dev-vpc.id
}

output "dev-pub-subnet-id" {
    value = aws_subnet.dev-pub-subnet.id
}