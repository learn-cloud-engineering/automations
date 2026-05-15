variable "cohort_code" {
  type = string

  validation {
    condition     = can(regex("^ce[0-9]{2}$", var.cohort_code))
    error_message = "Cohort code must be in the format 'ceXX' where X is a digit."
  }
}

variable "student_file" {
  type        = string
  description = "Path to a text file containing student usernames, one on each line."
}
