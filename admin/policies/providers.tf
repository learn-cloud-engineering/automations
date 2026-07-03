// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
      NukeProtection = "Enabled"
      Owner          = "SCTP"
      Source         = "https://github.com/su-ntu-ctp/cloud-cohorts"
    }
  }
}
provider "aws" {
  alias  = "us"
  region = "us-east-1"
  default_tags {
    tags = {
      NukeProtection = "Enabled"
      Owner          = "SCTP"
      Source         = "https://github.com/su-ntu-ctp/cloud-cohorts"
    }
  }
}
