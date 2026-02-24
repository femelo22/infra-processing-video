# VPC existente
data "aws_vpc" "existing" {
  id = var.vpc_id
}

# Subnets privadas da VPC
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Security Group existente
data "aws_security_group" "existing" {
  id = var.security_group_id
}