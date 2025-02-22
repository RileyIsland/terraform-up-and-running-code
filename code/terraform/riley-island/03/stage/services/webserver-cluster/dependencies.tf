data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "tf-up-and-running-riley-island-tfstates"
    key    = "03/stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
  }
}
