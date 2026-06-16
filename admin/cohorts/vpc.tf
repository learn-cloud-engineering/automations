module "vpc" {
  source   = "terraform-aws-modules/vpc/aws"
  version  = "~> 6.6.0"
  for_each = local.active_cohorts

  name = "sctp-vpc-${each.key}"

  enable_nat_gateway = true
  single_nat_gateway = true

  azs = ["${each.value.region}a", "${each.value.region}b"]

  cidr = "10.${tonumber(replace(each.key, "ce", ""))}.0.0/16"

  public_subnets = [
    "10.${tonumber(replace(each.key, "ce", ""))}.1.0/24",
    "10.${tonumber(replace(each.key, "ce", ""))}.2.0/24",
  ]

  private_subnets = [
    "10.${tonumber(replace(each.key, "ce", ""))}.11.0/24",
    "10.${tonumber(replace(each.key, "ce", ""))}.12.0/24",
  ]

  intra_subnets = [
    "10.${tonumber(replace(each.key, "ce", ""))}.111.0/24",
    "10.${tonumber(replace(each.key, "ce", ""))}.112.0/24",
  ]

  tags = {
    Cohort         = "sctp-cloud-${each.key}"
    Region         = each.value.region
    NukeProtection = "Enabled"
  }
}
