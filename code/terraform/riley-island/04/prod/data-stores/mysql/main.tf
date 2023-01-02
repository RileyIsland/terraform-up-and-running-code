module "db" {
  source = "../../../modules/data-stores/mysql"

  db_name           = "db_04_prod"
  db_password       = "db_password_04_prod"
  db_username       = "db_username_04_prod"
  identifier_prefix = "db-04-prod"
}
