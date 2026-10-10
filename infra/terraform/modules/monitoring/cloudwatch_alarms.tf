resource "aws_cloudwatch_metric_alarm" "ecs_running_task_alarms" {
  for_each = var.ecs_running_task_alarms

  alarm_name          = "${var.project_settings.project_name}-${each.key}-running-task-low"
  alarm_description   = "${each.key} running task count is below the ${each.value.threshold} threshold"
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  metric_name         = each.value.metric_name
  namespace           = each.value.namespace
  period              = each.value.period
  statistic           = each.value.statistic
  threshold           = each.value.threshold
  actions_enabled     = each.value.actions_enabled
  alarm_actions       = [aws_sns_topic.this.arn]
  datapoints_to_alarm = each.value.datapoints_to_alarm
  treat_missing_data  = each.value.treat_missing_data
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.ecs_service_names
  }
}

resource "aws_cloudwatch_metric_alarm" "dlq_alarm" {
  alarm_name          = "${var.project_settings.project_name}-dlq-alarm"
  alarm_description   = "${var.project_settings.project_name} DLQ alarm"
  comparison_operator = var.dlq_alarm.comparison_operator
  evaluation_periods  = var.dlq_alarm.evaluation_periods
  metric_name         = var.dlq_alarm.metric_name
  namespace           = var.dlq_alarm.namespace
  period              = var.dlq_alarm.period
  statistic           = var.dlq_alarm.statistic
  threshold           = var.dlq_alarm.threshold
  actions_enabled     = var.dlq_alarm.actions_enabled
  alarm_actions       = [aws_sns_topic.this.arn]
  datapoints_to_alarm = var.dlq_alarm.datapoints_to_alarm
  treat_missing_data  = var.dlq_alarm.treat_missing_data
  dimensions = {
    QueueName = var.dlq_name
  }
  tags = {
    Project     = "${var.project_settings.project_name}-dlq-alarm"
    Environment = var.project_settings.environment
  }
}


resource "aws_cloudwatch_metric_alarm" "rds_alarm" {
  alarm_name          = "${var.project_settings.project_name}-rds-alarm"
  alarm_description   = "${var.project_settings.project_name} RDS alarm"
  comparison_operator = var.rds_alarm.comparison_operator
  evaluation_periods  = var.rds_alarm.evaluation_periods
  metric_name         = var.rds_alarm.metric_name
  namespace           = var.rds_alarm.namespace
  period              = var.rds_alarm.period
  statistic           = var.rds_alarm.statistic
  threshold           = var.rds_alarm.threshold
  actions_enabled     = var.rds_alarm.actions_enabled
  alarm_actions       = [aws_sns_topic.this.arn]
  datapoints_to_alarm = var.rds_alarm.datapoints_to_alarm
  treat_missing_data  = var.rds_alarm.treat_missing_data
  dimensions = {
    DBInstanceIdentifier = var.db_instance_identifier
  }
  tags = {
    Project     = "${var.project_settings.project_name}-rds-alarm"
    Environment = var.project_settings.environment
  }
}
