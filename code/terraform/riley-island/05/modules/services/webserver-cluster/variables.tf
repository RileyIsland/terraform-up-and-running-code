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

variable "ami" {
  default     = "ami-0283a57753b18025b"
  description = "The AMI to run in the cluster"
  type        = string
}

variable "custom_tags" {
  default     = {}
  description = "Custom tags to set on the instances in the ASG"
  type        = map(string)
}

variable "enable_autoscaling" {
  default    = false
  description = "If set to true, enable auto scaling"
  type       = bool
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The type of EC2 instances to run (e.g. t2.micro)"
  type        = string
}

variable "max_size" {
  default     = 2
  description = "The maximum number of EC2 instances in the ASG"
  type        = number
}

variable "min_size" {
  default     = 2
  description = "The minimum number of EC2 instances in the ASG"
  type        = number
}

variable "server_port" {
  default     = 8080
  description = "The port the server will use for HTTP requests"
  type        = number
}

variable "server_text" {
  default     = "Let us try this again!"
  description = "The text the web server should return"
  type        = string
}
