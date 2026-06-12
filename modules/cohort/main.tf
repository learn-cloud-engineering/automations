locals {
  region      = var.region
  students    = var.students
  cohort_name = "sctp-cloud-${var.cohort_code}"
  path        = "/students/${var.cohort_code}/"
}

resource "aws_iam_group" "cohort" {
  name = local.cohort_name
  path = local.path
}

resource "aws_iam_user" "students" {
  for_each      = { for s in local.students : s.aws_username => s }
  name          = each.value.aws_username
  path          = local.path
  force_destroy = true

  tags = {
    Cohort      = local.cohort_name
    Region      = local.region
    StudentName = each.value.name
  }
}

resource "aws_iam_user_group_membership" "add_students" {
  for_each = aws_iam_user.students
  user     = each.value.name
  groups   = [aws_iam_group.cohort.name]
}

resource "aws_iam_group_policy_attachment" "student_policies" {
  for_each   = toset(var.policy_arns)
  group      = aws_iam_group.cohort.name
  policy_arn = each.value
}

resource "aws_iam_user_login_profile" "students" {
  for_each                = aws_iam_user.students
  user                    = each.value.name
  password_reset_required = true
}
