provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "stage" {
  identifier_prefix   = "stage-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  db_name             = "stage_database"

  username = var.db_username
  password = var.db_password
}

terraform {
  backend "s3" {
    bucket = "stage-up-and-running-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "stage-up-and-running-locks"
    encrypt        = true
  }
}