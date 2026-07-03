module "bucket_sg" {
  source   = "../../modules/bucket"
  for_each = local.active_cohorts_sg

  bucket_name   = "sctp-tfstate-${each.key}"
  cohort_code   = each.key
  force_destroy = false
}

module "bucket_us" {
  source   = "../../modules/bucket"
  for_each = local.active_cohorts_us

  bucket_name   = "sctp-tfstate-${each.key}"
  cohort_code   = each.key
  force_destroy = false

  providers = {
    aws = aws.us
  }
}
