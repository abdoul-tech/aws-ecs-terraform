resource "aws_security_group" "elb_sg" {
  name        = "alb-${var.application_name}-${terraform.workspace}"
  description = "SG of the loadbalancer"
  vpc_id      = var.vpc_id
  ingress     = [
    {
      description = ""
      from_port   = 80
      to_port     = 80
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      ipv6_cidr_blocks = []
      protocol         = "tcp"
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
  ]
  egress = [
    {
      description = ""
      from_port   = 0
      to_port     = 65535
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      ipv6_cidr_blocks = []
      protocol         = "tcp"
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
  ]
  tags = merge(
    var.default_tags,
    {
      component     = "sg"
    },
  )
}

