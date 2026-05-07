variable "cohort_code" {
  type = string

  validation {
    condition     = can(regex("^ce[0-9]{2}$", var.cohort_code))
    error_message = "Cohort code must be in the format 'ceXX' where X is a digit."
  }
}

variable "usernames" { type = list(string) }