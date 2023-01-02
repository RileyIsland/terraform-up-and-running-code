module "db" {
  source = "../../../modules/data-stores/mysql"

  db_name           = "db_04_stage"
  db_password       = "db_password_04_stage"
  db_username       = "db_username_04_stage"
  identifier_prefix = "db-04-stage"
}
