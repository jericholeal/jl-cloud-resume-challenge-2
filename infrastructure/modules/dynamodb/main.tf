# DynamoDB Module Configuration

resource "aws_dynamodb_table" "jlcrc2_visitor_counter_table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.dynamodb_table_partition_key
  attribute {
    name = var.dynamodb_table_partition_key
    type = "S"
  }
  attribute {
    name = var.dynamodb_table_counter_attribute
    type = "N"
  }
  tags = {
    Project = var.project_name
  }
}

resource "aws_dynamodb_table" "jlcrc2_terraform_lock_table" {
  name         = var.dynamodb_terraform_lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Project = var.project_name
  }
}

