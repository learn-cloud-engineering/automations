locals {
  cohorts = []
}

resource "scalr_workspace" "cohorts" {
  for_each = toset(local.cohorts)

  environment_id  = data.scalr_environment.cohorts.id
  vcs_provider_id = data.scalr_vcs_provider.github.id

  name              = "cohorts-ce${each.key}"
  working_directory = "cohorts/ce${each.key}"

  vcs_repo {
    identifier       = "learn-cloud-engineering/automations"
    branch           = "main"
    trigger_prefixes = ["cohorts/ce${each.key}"]
  }
}

resource "scalr_workspace" "policies" {
  environment_id  = data.scalr_environment.cohorts.id
  vcs_provider_id = data.scalr_vcs_provider.github.id

  name              = "admin-policies"
  working_directory = "admin/policies"

  vcs_repo {
    identifier       = "learn-cloud-engineering/automations"
    branch           = "main"
    trigger_prefixes = ["admin/policies"]
  }
}
