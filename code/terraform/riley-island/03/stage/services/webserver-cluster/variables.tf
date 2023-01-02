variable "server_port" {
  default     = 8080
  description = "The port the server will use for HTTP requests"
  type        = number
}

variable "alb_name" {
  default     = "terraform-asg-example"
  description = "The name of the ALB"
  type        = string
}

variable "instance_security_group_name" {
  default     = "terraform-example-instance"
  description = "The name of the security group for the EC2 Instances"
  type        = string
}

variable "alb_security_group_name" {
  default     = "terraform-example-alb"
  description = "The name of the security group for the ALB"
  type        = string
}
