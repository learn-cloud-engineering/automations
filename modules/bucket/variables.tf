variable "bucket_name" {
  type        = string
  description = "Globally unique name for the S3 bucket."
}

variable "cohort_code" {
  type        = string
  description = "Cohort code used for tagging."
}

variable "force_destroy" {
  type        = bool
  description = "Allow bucket and objects to be destroyed when set to true."
}
