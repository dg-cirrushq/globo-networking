##################################################################################
# OUTPUT
##################################################################################

output "vpc_id" {
  value       = module.main.vpc_id
  description = "VPC ID"
}

output "public_subnets" {
  value       = module.main.public_subnets
  description = "List of pub subs"
}