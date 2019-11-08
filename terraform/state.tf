provider "aws" {
  version = "~> 2.0"
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    key            = "marsha-plugins.tfstate"
    bucket         = "marsha-plugins-terraform-state"
    dynamodb_table = "marsha_plugins_terraform_state_locks"
    encrypt        = true
  }
}
