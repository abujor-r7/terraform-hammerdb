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
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "${aws_db_instance.hammerdb_dev.id}"],
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
            ["AWS/RDS", "DBLoad", "DBInstanceIdentifier", "${aws_db_instance.hammerdb_dev.id}"],
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
            ["AWS/RDS", "DBLoadCPU", "DBInstanceIdentifier", "${aws_db_instance.hammerdb_dev.id}"],
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
            ["AWS/RDS", "DBLoadNonCPU", "DBInstanceIdentifier","${aws_db_instance.hammerdb_dev.id}"],
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
            ["AWS/RDS", "DBLoadRelativeToNumVCPUs", "DBInstanceIdentifier", "${aws_db_instance.hammerdb_dev.id}"],
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
            ["AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${aws_db_instance.hammerdb_dev.id}"],
          ]
        }
      }
    ]
  })
}
