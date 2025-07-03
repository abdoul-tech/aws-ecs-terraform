variable "application_name" {
    type = string
}

variable "domaines" {
    description = "Domaines list used in lb listener rule conditions"
}

variable "default_tags" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "aws_lb_arn" {
  type = string
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "health_check_matcher" {
  type    = string
  default = "200"
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "health_check_healthy_threshold" {
  type    = number
  default = 2
}

variable "health_check_interval" {
  type    = number
  default = 30
}

variable "health_check_timeout" {
  type    = number
  default = 20
}

variable "health_check_unhealthy_threshold" {
  type    = number
  default = 5
}
