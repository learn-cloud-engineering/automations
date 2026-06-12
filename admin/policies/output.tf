output "policy_document_arns" {
  value = {
    for p in aws_iam_policy.policies : p.name => p.arn
  }
}
