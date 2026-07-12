resource "aws_iam_role" "nuke" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        }
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:su-ntu-ctp/aws-clean-up:*"
        }
      }
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::255945442255:oidc-provider/token.actions.githubusercontent.com"
      }
      Sid = "AllowGitHubActionsOIDCToAssumeRole"
      }, {
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::255945442255:user/jsstrn"
      }
      Sid = "AllowIAMUserToAssumeRole"
    }]
    Version = "2012-10-17"
  })
  description           = "This role is used by aws-nuke to clean up the resources in this AWS account."
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "AWSNukeAdminRole"
  path                  = "/"
  permissions_boundary  = null
}

resource "aws_iam_role" "scalr" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "scalr.io:aud" = "sctp-aws-scalr-oidc"
        }
        StringLike = {
          "scalr.io:sub" = ["account:sctp:environment:sctp-cloud-engineering:workspace:*", "account:sctp:environment:sctp-cloud-engineering:workspace:*"]
        }
      }
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::255945442255:oidc-provider/scalr.io"
      }
    }]
    Version = "2012-10-17"
  })
  description           = "This role grants Scalr.io permission to create and manage cohorts through Terraform configurations."
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "ScalrServiceRole"
  path                  = "/"
  permissions_boundary  = null
}
