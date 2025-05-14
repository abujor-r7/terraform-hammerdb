# Shared DB Subnet Group
resource "aws_db_subnet_group" "hammerdb_subnet_group" {
  name = "hammerdb-subnet-group"
  subnet_ids = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id,
    aws_subnet.public_c.id
  ]
  tags = {
    Name = "hammerdb-subnet-group"
  }
}
# Dev Environment DB
resource "aws_db_instance" "hammerdb_dev" {
  identifier             = "hammerdb-dev-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.m5.large"
  allocated_storage      = 20
  storage_type           = "gp3"
  multi_az               = true
  db_name                = "hammerdb_dev"
  username               = local.rds_credentials.username
  password               = local.rds_credentials.password
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.hammerdb_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.hammerdb_subnet_group.name
  tags = {
    Environment = "dev"
    Name        = "hammerdb-dev-db"
  }
}
