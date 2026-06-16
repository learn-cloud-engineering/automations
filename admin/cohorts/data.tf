data "aws_iam_policy" "administrator_access" {
  name = "AdministratorAccess"
}

data "aws_iam_policy" "iam_user_change_password" {
  name = "IAMUserChangePassword"
}

data "aws_iam_policy" "allow_ec2_operations_for_instance_types" {
  name = "SCTPAllowEC2OperationsForInstanceTypes"
}

data "aws_iam_policy" "allow_non_iam_actions_in_specific_regions" {
  name = "SCTPAllowNonIAMActionsInSpecificRegions"
}

data "aws_iam_policy" "deny_actions_outside_specific_regions" {
  name = "SCTPDenyActionsOutsideSpecificRegions"
}

data "aws_iam_policy" "deny_delete_cohort_vpc" {
  name = "SCTPDenyDeleteCohortVpc"
}

data "aws_iam_policy" "deny_iam_privilege_escalation" {
  name = "SCTPDenyIAMPrivilegeEscalation"
}

data "aws_iam_policy" "deny_specific_services" {
  name = "SCTPDenySpecificServices"
}

data "aws_iam_policy" "original_learners_policy" {
  name = "SCTPOriginalLearnersPolicy"
}

data "aws_iam_policy" "restrict_instance_types" {
  name = "SCTPRestrictInstanceTypes"
}
