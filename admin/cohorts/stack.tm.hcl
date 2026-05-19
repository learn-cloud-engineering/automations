stack {
  name        = "Cohorts"
  description = "All cohorts managed from a single YAML file."
  after       = ["tag:admin/policies"]
  tags        = ["admin/cohorts"]
}
