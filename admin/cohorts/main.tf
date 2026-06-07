locals {
  all_cohorts = yamldecode(file("${path.module}/../../data/cohorts.yaml"))
  active_cohorts = {
    for c in local.all_cohorts.cohorts : c.code => c
    if c.status == "active"
  }
}

module "cohort" {
  for_each    = local.active_cohorts
  source      = "../../modules/cohort"
  cohort_code = each.value.code
  cohort_name = each.value.name
  region      = each.value.region
  students    = each.value.students
}
