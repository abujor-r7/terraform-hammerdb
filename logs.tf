resource "aws_cloudwatch_log_group" "hammerdb_logs" {
  name              = "/ecs/hammerdb"
  retention_in_days = 7

  tags = {
    Name = "hammerdb-log-group"
  }
}
