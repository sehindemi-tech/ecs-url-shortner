output "vpc_flow_log_cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group for VPC flow logs"
  value       = aws_cloudwatch_log_group.vpc_flow_log.arn
}
