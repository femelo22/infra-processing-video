aws_region  = "us-east-1"
project     = "lanchonete"
environment = "dev"

vpc_id            = "vpc-pegar-na-conta"
security_group_id = "sg-pegar-na-conta"

db_name     = "apivideo"
db_username = "admin"
db_password = "sua-senha"

common_tags = {
  Project = "FIAP_BOOTCAMP"
  Owner   = "DevOps Team"
}