resource "aws_db_instance" "example" {
  identifier_prefix   = var.identifier_prefix
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  db_name             = var.db_name

  # How should we set the username and password?
  password = var.db_password
  username = var.db_username
}
