resource "aws_dynamodb_table" "terraform-state-locks" {
  name           = "marsha_plugins_terraform_state_locks"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
