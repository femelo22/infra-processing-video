variable "aws_region" { type = string }

variable "project" { type = string }

variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging or prod"
  }
}

variable "vpc_id" { type = string }

variable "security_group_id" { type = string }

variable "db_name" { type = string }

variable "db_username" { type = string }

variable "db_password" {
  type      = string
  sensitive = true
}

variable "engine_version" {
  type    = string
  default = "8.0"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "storage" {
  type    = number
  default = 20
}

variable "max_storage" {
  type    = number
  default = 100
}

variable "backup_days" {
  type    = number
  default = 7
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "common_tags" {
  type    = map(string)
  default = {}
}