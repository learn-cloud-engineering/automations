locals {
  policy_documents = fileset(path.module, "policy-documents/*.json")
}

resource "aws_iam_policy" "policies" {
  for_each = local.policy_documents

  name        = replace(basename(each.value), ".json", "")
  description = "Managed policy generated from ${each.value}"

  policy = file("${path.module}/${each.value}")

  tags = {
    Owner = "SCTP"
  }
}
