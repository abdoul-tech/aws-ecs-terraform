resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/${var.application_name}-${terraform.workspace}/app"
  tags = merge(
    var.default_tags,
    {
      component = "log_group"
    },
  )
}
