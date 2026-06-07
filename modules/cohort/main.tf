locals {
  cohort_name = "sctp-cloud-${var.cohort_code}"
  path        = "/students/${var.cohort_code}/"
}

resource "aws_iam_group" "cohort" {
  name = local.cohort_name
  path = local.path
}

resource "aws_iam_user" "students" {
  for_each = { for s in var.students : s.aws_username => s }
  name     = each.value.aws_username
  path     = local.path

  tags = {
    Cohort = local.cohort_name
  }
}

resource "aws_iam_user_group_membership" "add_students" {
  for_each = aws_iam_user.students
  user     = each.value.name
  groups   = [aws_iam_group.cohort.name]
}
