# IAM Role for RDS Proxy
resource "aws_iam_role" "rds_proxy_role" {
  name = "rds-proxy-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "rds.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = "rds-proxy-role"
  }
}

# Create RDS Proxy
resource "aws_db_proxy" "testbed_proxy" {
  name          = "testbed-db-proxy"
  engine_family = "MYSQL"
  role_arn      = aws_iam_role.rds_proxy_role.arn
  vpc_subnet_ids = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id,
    aws_subnet.public_c.id
  ]
  vpc_security_group_ids = [aws_security_group.hammerdb_sg.id]
  require_tls            = true
  auth {
    auth_scheme = "SECRETS"
    iam_auth    = "DISABLED"
    secret_arn  = data.aws_secretsmanager_secret.rds_credentials.arn
  }
  tags = {
    Name = "testbed-db-proxy"
  }
}

resource "aws_db_proxy_default_target_group" "default_group" {
  db_proxy_name = aws_db_proxy.testbed_proxy.name
  connection_pool_config {
    max_idle_connections_percent = 50
    max_connections_percent = 100
    connection_borrow_timeout = 120
    session_pinning_filters = [ "EXCLUDE_VARIABLE_SETS" ]
  }
}
resource "aws_db_proxy_target" "hammerdb_proxy_target" {
  db_instance_identifier = aws_db_instance.hammerdb_dev.identifier
  db_proxy_name          = aws_db_proxy.testbed_proxy.name
  target_group_name      = "default"
}
