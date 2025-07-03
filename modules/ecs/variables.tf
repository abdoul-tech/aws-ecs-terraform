variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "tg_arn" {
  description = "Target group ARN"
  type        = string
}

variable "cluster_arn" {
  description = "ECS cluster ARN"
  type        = string
}

variable "execution_role_arn" {
  description = "ECS execution role ARN"
  type        = string
}

variable "sg" {
  description = "Security group ID"
  type        = string
}

variable "subnet_ecs" {
  description = "Subnet IDs for ECS tasks"
  type        = list(string)
}

variable "container_port" {
  description = "Port on which the container listens"
  type        = number
}

variable "host_port" {
  description = "Port on the host"
  type        = number
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
}

variable "app_image" {
  description = "Docker image for the application"
  type        = string
}

variable "app_count" {
  description = "Number of application instances"
  type        = number
}

variable "fargate_cpu" {
  description = "Fargate CPU units"
  type        = number
}

variable "fargate_memory" {
  description = "Fargate memory in MB"
  type        = number
}
