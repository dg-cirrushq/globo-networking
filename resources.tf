##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment  = var.environment
      Owner        = var.owner
      Project      = var.project
      billing_code = var.billing_code
    }
  }
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}

##################################################################################
# RESOURCES
##################################################################################
locals {
  common_tags = {

  }
}

module "main" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.prefix
  cidr = var.cidr_block

  azs                     = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnets))
  public_subnets          = [for k, v in var.public_subnets : v]
  public_subnet_names     = [for k, v in var.public_subnets : "${var.prefix}-${k}"]
  enable_dns_hostnames    = true
  public_subnet_suffix    = ""
  public_route_table_tags = { Name = "${var.prefix}-public" }
  map_public_ip_on_launch = true

  enable_nat_gateway = false

  tags = local.common_tags
}