#ECS Cluster
resource "aws_ecs_cluster" "hammerdb_cluster" {
  name = "hammerdb-cluster"
}

resource "aws_ecs_task_definition" "hammerdb_task" {
  family                   = "hammerdb-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "hammerdb"
      image     = "tpcorg/hammerdb:latest"
      essential = true
      portMappings = [
        {
          containerPort = 5901
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.hammerdb_logs.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "hammerdb"
        }
      }

      environment = [
        {
          name  = "DB_HOST"
          value = aws_db_proxy.testbed_proxy.endpoint
        }
      ]
    }
  ])
}
