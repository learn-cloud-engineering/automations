
variable "policy_files" {
  description = "A list of the policy files"
  type        = list(string)
  default = [
    "SCTPDenyActionsOutsideSpecificRegions",
    "SCTPDenyIAMPrivilegeEscalation",
    "SCTPDenySpecificServices",
    "SCTPRestrictInstanceTypes"
  ]
}

run "assert_all_policies_are_created" {
  command = apply

  assert {
    condition     = length(aws_iam_policy.policies) == 4
    error_message = "There should be 4 policies created"
  }
}

run "assert_tags_are_set" {
  command = apply

  assert {
    condition     = alltrue([for p in aws_iam_policy.policies : p.tags["Source"] == "https://github.com/jsstrn/learn-cloud-engineering"])
    error_message = "The Source tag is not set correctly"
  }
}
