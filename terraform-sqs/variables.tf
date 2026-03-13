variable "aws_region" {
  type        = string
  description = "Região AWS"
}

variable "queue_name" {
  type        = string
  description = "Nome da fila SQS"
}

variable "environment" {
  type        = string
  description = "Ambiente (dev, staging, prd)"
}

variable "max_receive_count" {
  type        = number
  description = "Número máximo de tentativas antes de enviar para DLQ"
  default     = 5
}

variable "common_tags" {
  type        = map(string)
  description = "Tags padrão"
  default     = {}
}