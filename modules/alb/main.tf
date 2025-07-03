data "aws_lb" "lb" {
  arn = var.aws_lb_arn
}

data "aws_alb_listener" "lb" {
  load_balancer_arn = data.aws_lb.lb.arn
  port              = var.listener_port
}

resource "aws_lb_listener_rule" "forward" {
  listener_arn = data.aws_alb_listener.lb.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  condition {
    host_header {
      values = var.domaines
    }
  }

  tags = merge(
    var.default_tags,
    {
      component = "lb_listener_rule"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "${lower(var.application_name)}-${lower(terraform.workspace)}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  target_type = "ip"

  slow_start           = 30
  deregistration_delay = 10

  health_check {
    enabled             = true
    healthy_threshold   = var.health_check_healthy_threshold
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = var.health_check_timeout
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = merge(
    var.default_tags,
    {
      component = "tg"
    },
  )

  lifecycle {
    create_before_destroy = false
  }
}
