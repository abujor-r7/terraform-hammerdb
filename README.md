# 🔨 HammerDB AWS Infrastructure (Terraform)

This Terraform project manages infrastructure related to the HammerDB setup in AWS.

---

## ✅ What's Managed

This project creates and manages the following AWS resources:

- **IAM Role for RDS Proxy**  
  → `aws_iam_role.rds_proxy_role`  
  Used by the RDS Proxy to interact with AWS services securely.

- **RDS Proxy**  
  → `aws_db_proxy.testbed_proxy`  
  Provides a database proxy for the RDS MySQL instance to improve connection management and scalability.

- **CloudWatch Log Group**  
  → `aws_cloudwatch_log_group.hammerdb_logs`  
  Stores logs for ECS tasks running HammerDB.

- **ECS Cluster and Task Definition**  
  → `aws_ecs_cluster.hammerdb_cluster`  
  → `aws_ecs_task_definition.hammerdb_task`  
  Runs HammerDB workloads in a containerized environment.

- **VPC and Subnets**  
  → `aws_vpc.main`  
  → `aws_subnet.public_a`, `aws_subnet.public_b`, `aws_subnet.public_c`  
  Provides the networking infrastructure for the project.

- **RDS MySQL Instance**  
  → `aws_db_instance.hammerdb_dev`  
  A MySQL database instance for the HammerDB workload.

- **Security Group**  
  → `aws_security_group.hammerdb_sg`  
  Manages access to the RDS instance and ECS tasks.

---

## 🔄 What's Referenced (but not Managed)

Terraform is configured to **pull existing infrastructure** from AWS to avoid duplication or conflicts. This includes:

- ✅ **IAM Role for ECS Task Execution**  
  → `data.aws_iam_role.ecs_task_execution_role`  
  Used by ECS tasks to interact with AWS services.

---

## 📊 CloudWatch Dashboard

Created automatically under:  
**CloudWatch → Dashboards → RDS-Metrics**

### Included Metrics:

- `DBLoad`
- `DBLoadCPU`
- `DBLoadNonCPU`
- `DBLoadRelativeToNumCPUs`
- `DatabaseConnections`


---

## 🚀 Usage

To deploy the infrastructure, run the following commands:

```bash
terraform init
terraform plan
terraform apply