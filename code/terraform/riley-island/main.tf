provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0283a57753b18025b"
  instance_type = "t2.micro"
}
