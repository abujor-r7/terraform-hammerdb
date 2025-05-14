data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_iam_role_policy" "ecs_exec_policy" {
  name  = "ecs-exec-policy"
  role   = data.aws_iam_role.ecs_task_execution_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
          "ssm:StartSession",
          "ssm:UpdateInstanceInformation",
          "ssm:DescribeSessions", 
          "ssm:GetConnectionStatus",
        ]
        Resource = "*"
      }
    ]
  })
}

# IAM Role for Bastion Host
resource "aws_iam_role" "bastion_role" {
  name = "bastion-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
# Inline policy to allow ECS Exec
resource "aws_iam_role_policy" "bastion_ecs_exec_policy" {
  name = "bastion-ecs-exec-policy"
  role = aws_iam_role.bastion_role.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecs:ExecuteCommand",
          "ecs:DescribeTasks",
          "ssm:StartSession",
          "ssm:DescribeSessions",
          "ssmmessages:CreateDataChannel",
          "ecs:ListTasks",
          "ssmmessages:OpenDataChannel"
        ],
        Resource = "*"
      }
    ]
  })
}
# Instance profile to attach the role to the EC2 instance
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion-ec2-profile"
  role = aws_iam_role.bastion_role.name
}
