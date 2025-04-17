output "security_group_id" {
  value = aws_security_group.alb.id
}

output "target_group_arn" {
  value = aws_lb_target_group.app_target_group.arn
}

output "alb_url" {
  value = aws_lb.application_lb.dns_name
}

