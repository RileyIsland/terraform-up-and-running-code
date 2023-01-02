output "address" {
  description = "Connect to the database at this endpoint"
  value       = module.db.address
}

output "port" {
  description = "The port the database is listening on"
  value       = module.db.port
}
