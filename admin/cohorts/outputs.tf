output "cohort_students" {
  value     = merge([for c in module.cohort : c.students]...)
  sensitive = true
}
