resource "aws_ecs_task_definition" "task_definition" {
  container_definitions = jsonencode([
    {
      name       = "app"
      image      = var.app_image
      essential  = true
      cpu        = var.fargate_cpu
      environment = []
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          awslogs-group         = "/ecs/${var.application_name}-${terraform.workspace}/app"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
      memory            = var.fargate_memory
      memoryReservation = var.fargate_memory
      mountPoints       = []
      portMappings      = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
          protocol      = "tcp"
        },
      ]
      volumesFrom = []
    },
  ])
  
  cpu                      = tostring(var.fargate_cpu)
  execution_role_arn       = var.execution_role_arn
  family                   = "${var.application_name}-${terraform.workspace}"
  memory                   = tostring(var.fargate_memory)
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  
  tags = merge(
    var.default_tags,
    {
      component = "task-definition"
    },
  )
}

resource "aws_cloudwatch_log_group" "logs" {
  name              = "/ecs/${var.application_name}-${terraform.workspace}/app"
  retention_in_days = 30

  tags = merge(
    var.default_tags,
    {
      component = "cloudwatch"
    },
  )
}

resource "aws_ecs_service" "webapp" {
  name            = "${var.application_name}-${terraform.workspace}"
  cluster         = var.cluster_arn
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  load_balancer {
    container_name   = "app"
    container_port   = var.container_port
    target_group_arn = var.tg_arn
  }

  network_configuration {
    security_groups = [var.sg]
    subnets         = var.subnet_ecs
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = false
  }

  depends_on = [
    aws_cloudwatch_log_group.logs,
  ]

  tags = merge(
    var.default_tags,
    {
      component = "ecs-service"
    },
  )
}
