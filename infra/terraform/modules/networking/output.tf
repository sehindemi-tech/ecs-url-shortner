output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.url_shortner.id
}

output "s3_gateway_vpc_endpoint_id" {
  description = "The ID of the S3 gateway VPC endpoint"
  value       = aws_vpc_endpoint.gateway.prefix_list_id
}
