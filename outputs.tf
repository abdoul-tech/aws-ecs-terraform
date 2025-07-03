output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = module.cloudfront.cloudfront_main_domain_name
}

output "cloudfront_arn" {
  description = "CloudFront distribution ARN"
  value       = module.cloudfront.cloudfront_arn
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = module.lb.dns_name
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = module.lb.tg_arn
}

output "ecs_service_name" {
  description = "ECS Service name"
  value       = "${var.application_name}-${terraform.workspace}"
}

output "log_group_name" {
  description = "CloudWatch Log Group name"
  value       = "/ecs/${var.application_name}-${terraform.workspace}/app"
}
