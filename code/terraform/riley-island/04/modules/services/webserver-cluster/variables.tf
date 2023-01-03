variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The type of EC2 instances to run (e.g. t2.micro)"
  type        = string
}

variable "min_size" {
  default     = 2
  description = "The minimum number of EC2 instances in the ASG"
  type        = number
}

variable "max_size" {
  default     = 2
  description = "The maximum number of EC2 instances in the ASG"
  type        = number
}

variable "server_port" {
  default     = 8080
  description = "The port the server will use for HTTP requests"
  type        = number
}
