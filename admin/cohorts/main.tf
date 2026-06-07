locals {
  all_cohorts = yamldecode(file("${path.module}/../../data/cohorts.yaml"))
  active_cohorts = {
    for c in local.all_cohorts.cohorts : c.code => c
    if c.status == "active"
  }

  policy_files = fileset("${path.module}/../../admin/policies/policy-documents/", "*.json")
  policy_names = [for f in local.policy_files : trimsuffix(f, ".json")]
}

data "aws_iam_policy" "student_policies" {
  for_each = toset(local.policy_names)
  name     = each.value
}

module "cohort" {
  for_each    = local.active_cohorts
  source      = "../../modules/cohort"
  cohort_code = each.value.code
  cohort_name = each.value.name
  region      = each.value.region
  students    = each.value.students
  policy_arns = values(data.aws_iam_policy.student_policies)[*].arn
}
