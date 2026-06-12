data "aws_iam_account_alias" "current" {}

output "students" {
  value = {
    for user, profile in aws_iam_user_login_profile.students : user => {
      username  = profile.user
      login_url = "https://${data.aws_iam_account_alias.current.account_alias}.signin.aws.amazon.com/console"
      password  = profile.password
    }
  }
  sensitive = true
}
