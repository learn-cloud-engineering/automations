variable "cohort_code" {
  type = string
  validation {
    condition     = can(regex("^ce[0-9]{2}$", var.cohort_code))
    error_message = "Cohort code must be in format 'ceXX'."
  }
}

variable "cohort_name" {
  type = string
}

variable "students" {
  type = list(object({
    name             = string
    aws_username     = string
    github_username  = string
    discord_username = string
  }))
}
