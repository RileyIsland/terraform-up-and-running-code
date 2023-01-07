terraform {
  backend "s3" {
    # Partial configuration. The other settings (e.g. bucket, region, dynamodb_table, encrypted)
    # will be passed in via -backend-config arguments to 'terraform-init'
    key = "05/stage/data-stores/mysql/terraform.tfstate"
  }

  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
