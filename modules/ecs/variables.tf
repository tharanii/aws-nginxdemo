variable "cluster_name" {
  description = "Name of the ECS cluster"
  default     = "hello-cluster"
}

variable "desired_count" {
  description = "Desired number of tasks"
  default     = 2
}

variable "subnets" {
  description = "Subnets for the ECS tasks"
  type        = list(string)
}

variable "security_group" {
  description = "Security group for the ECS tasks"
}

variable "target_group_arn" {
  description = "ARN of the target group for load balancing"
}
