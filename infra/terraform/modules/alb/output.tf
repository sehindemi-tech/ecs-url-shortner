output "alb_arn" {
  description = "ARN of the load balancer, for WAF association."
  value       = aws_lb.this.arn
}

output "alb_arn_suffix" {
  description = "ARN suffix, the dimension value for CloudWatch ALB metrics."
  value       = aws_lb.this.arn_suffix
}

output "alb_dns_name" {
  description = "DNS name of the load balancer, the Route 53 alias target."
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Hosted zone ID of the load balancer, for the Route 53 alias record."
  value       = aws_lb.this.zone_id
}
