resource "aws_ecs_service" "hammerdb_service" {
  name            = "hammerdb-service"
  cluster         = aws_ecs_cluster.hammerdb_cluster.id
  task_definition = aws_ecs_task_definition.hammerdb_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = [
      aws_subnet.public_a.id,
      aws_subnet.public_b.id,
      aws_subnet.public_c.id
    ]
    security_groups  = [aws_security_group.hammerdb_sg.id]
    assign_public_ip = true
  }

  deployment_controller {
    type = "ECS"
  }

  depends_on = [
    data.aws_iam_role.ecs_task_execution_role,
    aws_cloudwatch_log_group.hammerdb_logs,
  ]
}
