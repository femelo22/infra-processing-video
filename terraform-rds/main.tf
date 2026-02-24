terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  name_prefix = "${var.project}-${var.environment}"
}

resource "aws_db_subnet_group" "this" {
  name       = "${local.name_prefix}-subnet-group"
  subnet_ids = data.aws_subnets.private.ids

  tags = merge(var.common_tags, {
    Name        = "${local.name_prefix}-subnet-group"
    Environment = var.environment
  })
}

resource "aws_db_instance" "this" {
  identifier        = "${local.name_prefix}-mysql"
  engine            = "mysql"
  engine_version    = var.engine_version
  instance_class    = var.instance_class

  allocated_storage     = var.storage
  max_allocated_storage = var.max_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = 3306

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [data.aws_security_group.existing.id]

  publicly_accessible = false
  multi_az            = var.multi_az

  backup_retention_period = var.backup_days
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  performance_insights_enabled = false

  enabled_cloudwatch_logs_exports = ["error", "slowquery"]

  auto_minor_version_upgrade = true
  deletion_protection         = false
  skip_final_snapshot         = false
  final_snapshot_identifier   = "${local.name_prefix}-final"

  tags = merge(var.common_tags, {
    Name        = "${local.name_prefix}-rds"
    Environment = var.environment
    ManagedBy   = "Terraform"
  })
}