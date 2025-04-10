# 🔨 HammerDB AWS Infrastructure (Terraform)

This Terraform project manages infrastructure related to the HammerDB setup in AWS.

---

## ✅ What's Managed

**CloudWatch Dashboard** for monitoring key RDS metrics  
→ Created and versioned directly via Terraform

---

## 🔄 What's Referenced (but not Managed)

Terraform is configured to **pull existing infrastructure** from AWS to avoid duplication or conflicts. This includes:

- ✅ **VPC and Subnets**
- ✅ **RDS MySQL Instances**
- ✅ **ECS Cluster and Task Definitions**
- ✅ **CloudWatch Log Group**
- ✅ **IAM Roles and Security Groups**

All of the above are **read-only references** using Terraform `data` blocks.

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

All metrics are displayed across **3 RDS instances**.

---


## 🚀 Usage
```
terraform init
terraform plan
terraform apply
```
