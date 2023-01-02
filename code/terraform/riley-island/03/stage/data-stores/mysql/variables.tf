variable "db_password" {
  default     = "putmeinabetterplace"
  description = "The password for the database"
  sensitive   = true
  type        = string
}

variable "db_username" {
  default     = "putmeinabetterplace"
  description = "The username for the database"
  sensitive   = true
  type        = string
}
