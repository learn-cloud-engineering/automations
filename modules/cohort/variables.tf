variable "cohort_code" {
  type = string
  description = "Unique code for the cohort."
}

variable "cohort_name" {
  type = string
  description = "Descriptive name for the cohort."
}

variable "region" {
  type = string
  description = "AWS region where the cohort resources will be deployed."
}

variable "students" {
  type = list(object({
    name             = string
    aws_username     = string
  }))
}
