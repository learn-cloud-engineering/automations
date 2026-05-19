locals {
  scalr_vcs_provider_name = "sctp-github"
  scalr_environment_name  = "cloud-engineering-cohorts"
}

data "scalr_vcs_provider" "github" {
  name = local.scalr_vcs_provider_name
}

data "scalr_environment" "cohorts" {
  name = local.scalr_environment_name
}

