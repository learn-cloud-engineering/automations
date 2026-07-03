locals {
  all_cohorts = yamldecode(file("${path.module}/../../data/cohorts.yaml"))

  active_cohorts = {
    for c in local.all_cohorts.cohorts : c.code => c
    if c.status == "active"
  }

  active_cohorts_sg = {
    for c in local.all_cohorts.cohorts : c.code => c
    if c.status == "active" && c.region == "ap-southeast-1"
  }

  active_cohorts_us = {
    for c in local.all_cohorts.cohorts : c.code => c
    if c.status == "active" && c.region == "us-east-1"
  }
}
