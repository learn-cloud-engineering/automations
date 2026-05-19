stack {
  id          = "32ca12d9-f5f3-4e3e-93c4-9b3e30f05201"
  name        = "workspaces"
  description = "Creates workspaces for each stack."
  tags        = ["admin/workspaces"]
}

generate_hcl "scalr.tf" {
  content {
    terraform {
      required_providers {
        scalr = {
          source  = "Scalr/scalr"
          version = "~> 3.16.2"
        }
      }
    }

    provider "scalr" {}
  }
}
