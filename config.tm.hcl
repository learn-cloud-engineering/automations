globals {
  region = {
    sg = "ap-southeast-1"
    us = "us-east-1"
  }

  metadata = {
    owner      = "SCTP"
    source_url = "https://github.com/su-ntu-ctp/cloud-cohorts"
  }

  backend = {
    hostname     = "sctp.scalr.io"
    organization = "env-v0p5uejtsf2d7pjp6"
    workspace    = terramate.stack.path.basename
  }

  default_tags = {
    Owner          = "SCTP"
    Source         = "https://github.com/su-ntu-ctp/cloud-cohorts"
    NukeProtection = "Enabled"
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
      region = global.region.sg

      default_tags {
        tags = global.default_tags
      }
    }

    provider "aws" {
      alias  = "us"
      region = global.region.us

      default_tags {
        tags = global.default_tags
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
