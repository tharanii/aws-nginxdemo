output "target_group_arn" {
  description = "The ARN of the ALB target group"
  value       = aws_lb_target_group.hello.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.main.dns_name
}
