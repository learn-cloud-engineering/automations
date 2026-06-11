globals {
  region_tags = [for t in terramate.stack.tags : t if tm_startswith(t, "region/")]
  region      = tm_length(global.region_tags) > 0 ? tm_split("/", global.region_tags[0])[1] : "ap-southeast-1"

  source_url = "https://github.com/su-ntu-ctp/cloud-cohorts"
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
          ManagedBy = "Scalr.io"
          Owner     = "SCTP"
          Source    = global.source_url
        }
      }
    }
  }
}
