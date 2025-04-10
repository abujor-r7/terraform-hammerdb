data "aws_cloudwatch_log_group" "hammerdb_logs" {
  name = "/ecs/hammerdb-testbed"
  # retention_in_days = 7
}