data "aws_iam_account_alias" "current" {}

locals {
  account_alias  = data.aws_iam_account_alias.current.account_alias
  login_url      = "https://${local.account_alias}.signin.aws.amazon.com/console"
  login_profiles = aws_iam_user_login_profile.students
}

output "students" {
  value = {
    for s in local.students : s.aws_username => {
      name      = s.name
      username  = s.aws_username
      login_url = local.login_url
      password  = local.login_profiles[s.aws_username].password
    }
  }
  sensitive = true
}
