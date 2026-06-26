locals {
  all_cohorts = yamldecode(file("${path.module}/../../data/cohorts.yaml"))

  active_cohorts = {
    for c in local.all_cohorts.cohorts : c.code => c
    if c.status == "active"
  }
}

module "cohort" {
  source   = "../../modules/cohort"
  for_each = local.active_cohorts

  cohort_code = each.value.code
  cohort_name = each.value.name
  region      = each.value.region

  students = each.value.students

  policy_arns = [
    # AWS Managed Policies
    data.aws_iam_policy.administrator_access.arn,
    data.aws_iam_policy.iam_user_change_password.arn,

    # Customer Managed Policies
    data.aws_iam_policy.allow_ec2_operations_for_instance_types.arn,
    data.aws_iam_policy.allow_non_iam_actions_in_specific_regions.arn,
    data.aws_iam_policy.deny_actions_outside_specific_regions.arn,
    data.aws_iam_policy.deny_delete_cohort_vpc.arn,
    data.aws_iam_policy.deny_iam_privilege_escalation.arn,
    data.aws_iam_policy.deny_specific_services.arn,
    data.aws_iam_policy.original_learners_policy.arn,
    data.aws_iam_policy.restrict_instance_types.arn,
  ]
}
