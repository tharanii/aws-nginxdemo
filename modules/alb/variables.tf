variable "vpc_id" {
  description = "VPC ID for the load balancer"
}

variable "subnets" {
  description = "Subnets for the load balancer"
  type        = list(string)
}

variable "security_group" {
  description = "Security group for the load balancer"
}
