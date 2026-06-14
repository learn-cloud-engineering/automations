globals {
  region_tags = [for t in terramate.stack.tags : t if tm_startswith(t, "region/")]
  region      = tm_length(global.region_tags) > 0 ? tm_split("/", global.region_tags[0])[1] : "ap-southeast-1"

  metadata = {
    owner      = "SCTP"
    source_url = "https://github.com/su-ntu-ctp/cloud-cohorts"
  }

  backend = {
    hostname     = "sctp.scalr.io"
    organization = "env-v0p5uejtsf2d7pjp6"
    workspace    = terramate.stack.path.basename
  }
}

generate_hcl "versions.tf" {
  content {
    terraform {
      required_version = "~> 1.12.0"
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 6.36.0"
        }
      }
    }
  }
}

generate_hcl "providers.tf" {
  content {
    provider "aws" {
      region = global.region

      default_tags {
        tags = {
          Owner  = global.metadata.owner
          Source = global.metadata.source_url
        }
      }
    }
  }
}

generate_hcl "backend.tf" {
  content {
    terraform {
      backend "remote" {
        hostname     = global.backend.hostname
        organization = global.backend.organization
        workspaces { name = global.backend.workspace }
      }
    }
  }
}
