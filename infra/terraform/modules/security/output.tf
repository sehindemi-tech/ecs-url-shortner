output "keys_arns" {
  description = "The ARNs of the KMS keys"
  value       = { for name, key in aws_kms_key.this : name => key.arn }
}

output "key_ids" {
  description = "The IDs of the KMS keys"
  value       = { for name, key in aws_kms_key.this : name => key.id }
}

output "alias_name" {
  description = "The names of the KMS aliases"
  value       = { for name, alias in aws_kms_alias.this : name => alias.name }
}

output "vpc_endpoint_security_group_id" {
  description = "The security group ID associated with interface VPC endpoints"
  value       = aws_security_group.this["vpc_endpoints"].id
}

output "security_group_ids" {
  description = "The IDs of the security groups"
  value       = { for name, sg in aws_security_group.this : name => sg.id }
}
