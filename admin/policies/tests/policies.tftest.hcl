run "assert_all_policies_are_created" {
  command = apply

  assert {
    condition     = length(aws_iam_policy.policies) == 4
    error_message = "There should be 4 policies created"
  }
}
