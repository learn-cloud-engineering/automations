globals {
  region = "ap-southeast-1"
  source_url = "https://github.com/jsstrn/learn-cloud-engineering"
}

generate_hcl "versions.tf" {
  content {
    terraform {
      required_version = "~> 1.14.0"
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
          ManagedBy = "Terraform"
          Owner     = "SCTP"
          Source    = global.source_url
        }
      }
    }
  }
}
