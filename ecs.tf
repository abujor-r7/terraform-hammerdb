data "aws_ecs_cluster" "hammerdb_cluster" {
  cluster_name = "db-proxy-testbed-cluster"
}

data "aws_ecs_task_definition" "hammerdb" {
  task_definition = "hammerdb-testbed:2"
}