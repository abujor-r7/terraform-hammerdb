output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.hammerdb_cluster.name
}

output "rds_endpoint" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.hammerdb_dev.endpoint
}

output "rds_proxy_endpoint" {
  description = "The ID of the RDS instance"
  value       = aws_db_proxy.testbed_proxy.endpoint
}

output "public_a_subnet" {
  value = aws_subnet.public_a.id
}
output "public_b_subnet" {
  value = aws_subnet.public_b.id
}
output "public_c_subnet" {
  value = aws_subnet.public_c.id
}
