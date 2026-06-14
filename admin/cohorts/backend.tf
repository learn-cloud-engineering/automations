// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "remote" {
    hostname     = "sctp.scalr.io"
    organization = "env-v0p5uejtsf2d7pjp6"
    workspaces {
      name = "cohorts"
    }
  }
}
