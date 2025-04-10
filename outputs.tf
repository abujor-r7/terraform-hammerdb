output "vpc_id" {
  description = "The ID of the VPC"
  value       = data.aws_vpc.default_vpc.id
}
output "subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [
    data.aws_subnet.public_a.id,
    data.aws_subnet.public_b.id,
    data.aws_subnet.public_c.id
  ]
}
output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = data.aws_ecs_cluster.hammerdb_cluster.cluster_name
}
output "log_group_name" {
  description = "The name of the CloudWatch Log Group"
  value       = data.aws_cloudwatch_log_group.hammerdb_logs.name
}
output "task_definition_arn" {
  description = "The ARN of the ECS task definition"
  value       = data.aws_ecs_task_definition.hammerdb.arn
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = data.aws_db_instance.testbed_db.id
  
}