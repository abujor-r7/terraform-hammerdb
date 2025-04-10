resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "RDS-Dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          title = "CPUUtilization",
          view = "timeSeries",
          region = var.aws_region,
          stat = "Average",
          period = 300,
          metrics = [
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "db-proxy-testbed-instance-1"],
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "db-proxy-testbed-instance-2"],
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "db-proxy-testbed-instance-3"],
          ]
        }
      },
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          title = "DBLoad",
          view = "timeSeries",
          region = var.aws_region,
          stat = "Average",
          period = 300,
          metrics = [
            ["AWS/RDS", "DBLoad", "DBInstanceIdentifier", "db-proxy-testbed-instance-1"],
            ["AWS/RDS", "DBLoad", "DBInstanceIdentifier", "db-proxy-testbed-instance-2"],
            ["AWS/RDS", "DBLoad", "DBInstanceIdentifier", "db-proxy-testbed-instance-3"],
          ]
        }
      },
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          title = "DBLoadCPU",
          view = "timeSeries",
          region = var.aws_region,
          stat = "Average",
          period = 300,
          metrics = [
            ["AWS/RDS", "DBLoadCPU", "DBInstanceIdentifier", "db-proxy-testbed-instance-1"],
            ["AWS/RDS", "DBLoadCPU", "DBInstanceIdentifier", "db-proxy-testbed-instance-2"],
            ["AWS/RDS", "DBLoadCPU", "DBInstanceIdentifier", "db-proxy-testbed-instance-3"],
          ]
        }
      },
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          title = "DBLoadNonCPU",
          view = "timeSeries",
          region = var.aws_region,
          stat = "Average",
          period = 300,
          metrics = [
            ["AWS/RDS", "DBLoadNonCPU", "DBInstanceIdentifier", "db-proxy-testbed-instance-1"],
            ["AWS/RDS", "DBLoadNonCPU", "DBInstanceIdentifier", "db-proxy-testbed-instance-2"],
            ["AWS/RDS", "DBLoadNonCPU", "DBInstanceIdentifier", "db-proxy-testbed-instance-3"],
          ]
        }
      },
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          title = "DBLoadRelativeToNumVCPUs",
          view = "timeSeries",
          region = var.aws_region,
          stat = "Average",
          period = 300,
          metrics = [
            ["AWS/RDS", "DBLoadRelativeToNumVCPUs", "DBInstanceIdentifier", "db-proxy-testbed-instance-1"],
            ["AWS/RDS", "DBLoadRelativeToNumVCPUs", "DBInstanceIdentifier", "db-proxy-testbed-instance-2"],
            ["AWS/RDS", "DBLoadRelativeToNumVCPUs", "DBInstanceIdentifier", "db-proxy-testbed-instance-3"],
          ]
        }
      },
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          title = "DatabaseConnections",
          view = "timeSeries",
          region = var.aws_region,
          stat = "Average",
          period = 300,
          metrics = [
            ["AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "db-proxy-testbed-instance-1"],
            ["AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "db-proxy-testbed-instance-2"],
            ["AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "db-proxy-testbed-instance-3"],
          ]
        }
      }
    ]
  })
}