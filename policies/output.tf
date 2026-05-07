output "policy_document_arns" {
  value = {
    for p in aws_iam_policy.policies : p.name => p.arn
  }
}

output "administrator_access_policy_arn" {
  value = data.aws_iam_policy.administrator_access.arn
}
