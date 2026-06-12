data "aws_iam_policy" "administrator_access" {
  name = "AdministratorAccess"
}

data "aws_iam_policy" "iam_user_change_password" {
  name = "IAMUserChangePassword"
}
