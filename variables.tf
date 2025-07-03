variable "aws_region" {
  description = "The AWS region things are created in"
  type        = string
  default     = "us-east-1"
}

variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "short_name" {
  description = "Short name for the application"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "dns_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for SSL/TLS"
  type        = string
}

variable "ecs_execution_role_arn" {
  description = "ECS execution role ARN"
  type        = string
}

variable "ecs_cluster_arn" {
  description = "ECS cluster ARN"
  type        = string
}

variable "ecs_container_port" {
  description = "Port on which the container listens"
  type        = number
  default     = 80
}

variable "ecs_host_port" {
  description = "Port on the host"
  type        = number
  default     = 80
}

variable "aws_lb_arn" {
  description = "Application Load Balancer ARN"
  type        = string
}

variable "sg_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_alb" {
  description = "Subnet IDs for ALB"
  type        = list(string)
}

variable "subnet_ecs" {
  description = "Subnet IDs for ECS tasks"
  type        = list(string)
}

variable "domaines" {
  description = "List of domain names"
  type        = list(string)
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "app_image" {
  description = "Docker image for the application"
  type        = string
  default     = "strm/helloworld-http"
}

variable "app_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 80
}

variable "app_count" {
  description = "Number of application instances"
  type        = number
  default     = 1
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "fargate_cpu" {
  description = "Fargate CPU units"
  type        = number
  default     = 1024
}

variable "fargate_memory" {
  description = "Fargate memory in MB"
  type        = number
  default     = 2048
}

variable "terraform_state_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}