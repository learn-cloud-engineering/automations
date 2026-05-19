// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

locals {
  cohort_code = "ce99"
}
module "cohort" {
  cohort_code  = local.cohort_code
  source       = "../../modules/cohort"
  student_file = "${path.module}/students.txt"
}
