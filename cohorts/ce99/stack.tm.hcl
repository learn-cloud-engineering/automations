stack {
  id          = "5f5304ba-9c34-4861-a77b-d6faede91438"
  name        = "Cohort 99"
  description = "Resources for CE99"

  after = ["tag:policies"]
  tags  = ["ce99", "cohort", "region/us-east-1"]
}
