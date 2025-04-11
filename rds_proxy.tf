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
    secret_arn  = data.aws_secretsmanager_secret.aleksa_testbed.arn
  }
  tags = {
    Name = "testbed-db-proxy"
  }
}
