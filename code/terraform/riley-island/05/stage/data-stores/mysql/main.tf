module "db" {
  source = "../../../modules/data-stores/mysql"

  db_name           = "db_05_stage"
  db_password       = "db_password_05_stage"
  db_username       = "db_username_05_stage"
  identifier_prefix = "db-05-stage"
}
