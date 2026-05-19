generate_hcl "main.tf" {
  content {
    locals {
      cohort_code = terramate.stack.path.basename
    }

    module "cohort" {
      source       = "../../modules/cohort"
      cohort_code  = local.cohort_code
      student_file = "${path.module}/students.txt"
    }
  }
}
