variable "aws_region" {
  description = "Região AWS"
  type        = string
}

variable "bucket_name" {
  description = "Nome do bucket (deve ser globalmente único)"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
}

variable "common_tags" {
  description = "Tags padrão aplicadas a todos recursos"
  type        = map(string)
  default     = {}
}