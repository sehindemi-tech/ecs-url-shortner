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
