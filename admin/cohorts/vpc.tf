module "vpc" {
  source   = "terraform-aws-modules/vpc/aws"
  version  = "~> 6.6.0"
  for_each = local.active_cohorts

  name   = "sctp-vpc-${each.key}"
  region = each.value.region

  azs  = ["${each.value.region}a", "${each.value.region}b"]
  cidr = "10.${each.value.number}.0.0/16"

  public_subnets = [
    "10.${each.value.number}.1.0/24",
    "10.${each.value.number}.2.0/24",
  ]

  # public subnet configurations
  enable_dns_hostnames    = true
  map_public_ip_on_launch = true

  private_subnets = [
    "10.${each.value.number}.11.0/24",
    "10.${each.value.number}.12.0/24",
  ]

  # private subnet configurations
  enable_nat_gateway = true
  single_nat_gateway = true

  database_subnets = [
    "10.${each.value.number}.111.0/24",
    "10.${each.value.number}.112.0/24",
  ]

  # database subnet configurations
  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  tags = {
    Cohort = "sctp-cloud-${each.key}"
    Region = each.value.region
  }
}
