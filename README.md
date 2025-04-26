# 🔨 HammerDB AWS Infrastructure (Terraform + Ansible)

This project provisions and manages infrastructure related to the HammerDB testing setup in AWS.

---

## 🛠️ What’s Managed (Terraform)

The Terraform code manages the following AWS resources:

- **IAM Role for RDS Proxy**  
  → `aws_iam_role.rds_proxy_role`  
  Used by the RDS Proxy to securely access RDS databases.

- **RDS Proxy**  
  → `aws_db_proxy.testbed_proxy`  
  Improves connection pooling and scalability for the MySQL instance.

- **RDS Proxy Default Target Group**  
  → `aws_db_proxy_default_target_group.default_group`  
  Configures the default target group for the RDS Proxy.

- **RDS Proxy Target**  
  → `aws_db_proxy_target.hammerdb_proxy_target`  
  Registers the RDS instance with the RDS Proxy.

- **RDS MySQL Database**  
  → `aws_db_instance.hammerdb_dev`  
  MySQL database instance used for HammerDB load testing.

- **CloudWatch Log Group**  
  → `aws_cloudwatch_log_group.hammerdb_logs`  
  Stores logs for ECS containers running HammerDB.

- **CloudWatch Dashboard**  
  → `aws_cloudwatch_dashboard.ecs_dashboard`  
  Displays metrics for the RDS instance and ECS cluster.

- **ECS Cluster and Task Definition**  
  → `aws_ecs_cluster.hammerdb_cluster` and `aws_ecs_task_definition.hammerdb_task`  
  Defines the containerized HammerDB workloads.

- **VPC**  
  → `aws_vpc.main`  
  Provides the main virtual private cloud for the infrastructure.

- **Subnets**  
  → `aws_subnet.public_a`, `aws_subnet.public_b`, `aws_subnet.public_c`  
  Public subnets for the VPC.

- **Internet Gateway**  
  → `aws_internet_gateway.igw`  
  Enables internet access for resources in the public subnets.

- **Route Table**  
  → `aws_route_table.public_rt`  
  Configures routing for the public subnets.

- **Route Table Associations**  
  → `aws_route_table_association.public_a`, `aws_route_table_association.public_b`, `aws_route_table_association.public_c`  
  Associates the public subnets with the route table.

- **Security Group**  
  → `aws_security_group.hammerdb_sg` and `aws_security_group.bastion_sg`
  Manages access between the bastion host, RDS database, and ECS containers.

- **DB Subnet Group**  
  → `aws_db_subnet_group.hammerdb_subnet_group`  
  Configures subnets for the RDS instance.

- **Null Resource for Bastion Key**  
  → `null_resource.write_bastion_key`  
  Writes the bastion SSH private key to `~/.ssh/bastion_key.pem`.

---

## 🔄 What’s Referenced (but not Managed)

Terraform is also configured to pull existing infrastructure where needed to avoid duplication:

- **IAM Role for ECS Task Execution**  
  → `data.aws_iam_role.ecs_task_execution_role`

- **Secrets Manager**  
  → `data.aws_secretsmanager_secret.rds_credentials`, `data.aws_secretsmanager_secret_version.bastion_key`

---

## 🔑 Bastion Host and SSH Key Management

- The bastion SSH key is securely pulled from AWS Secrets Manager at provision time.
- Terraform saves it temporarily at `~/.ssh/bastion_key.pem`.
- Ansible uses this key to connect to the bastion host securely.

---

## 🔒 Security Group Configuration

- The Bastion Host can access the RDS database via the security group rules.
- ECS containers also have network access to the RDS proxy and database.

---

## 🚀 Usage (Terraform)

To deploy the infrastructure, run the following commands:

```bash
terraform init
terraform plan
terraform apply
```
---

## 📦 Usage (Ansible)

After the infrastructure is ready, you can provision the bastion host with the MySQL client by running:

```bash
ansible-playbook -i ansible-provision/inventory.ini ansible-provision/playbook.yml \  
-e "db_host=<RDS endpoint> db_user=<ASM username> db_password=<ASM password>"
```

This will:

- Install Python 3.9,
- Import required GPG keys,
Install the MySQL 8.x client,
- Set environment variables (DB_HOST, DB_USER, DB_PASSWORD)
- Note: Compatible with Amazon Linux 2023 on the bastion host.

---

## 📝 Notes
- Terraform state is stored remotely (e.g., in an S3 bucket).
- The Terraform AWS provider is restricted to the specific AWS account for security reasons.
