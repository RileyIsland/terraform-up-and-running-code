variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  sensitive   = true
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  sensitive   = true
  type        = string
}

variable "identifier_prefix" {
  description = "The DB instance identifier_prefix"
  type        = string
}
