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


# Fila principal
resource "aws_sqs_queue" "main" {
  name = var.queue_name

  visibility_timeout_seconds = 60
  message_retention_seconds  = 345600 # 4 dias
  receive_wait_time_seconds  = 10      # long polling

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count // numero de retentativas
  })

  tags = merge(var.common_tags, {
    Name        = var.queue_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "PrimaryQueue"
  })
}

# DLQ
resource "aws_sqs_queue" "dlq" {
  name = "${var.queue_name}-dlq"

  message_retention_seconds = 172800 # 2 dias

  tags = merge(var.common_tags, {
    Name        = "${var.queue_name}-dlq"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "DLQ"
  })
}