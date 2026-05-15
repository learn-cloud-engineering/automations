locals {
  cohort_name = "sctp-${var.cohort_code}-learners"
  students    = compact(split("\n", replace(trimspace(file(var.student_file)), "\r", "")))
  usernames   = [for name in local.students : "${name}-${var.cohort_code}"]
}

resource "aws_iam_group" "cohort" {
  name = local.cohort_name
  path = "/students/"
}

resource "aws_iam_user" "students" {
  for_each = toset(local.usernames)
  name     = each.value
  path     = "/students/"

  tags = {
    Cohort = local.cohort_name
  }
}

resource "aws_iam_user_group_membership" "add_students" {
  for_each = toset(local.usernames)
  user     = aws_iam_user.students[each.value].name
  groups   = [aws_iam_group.cohort.name]
}
