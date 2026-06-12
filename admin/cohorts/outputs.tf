output "cohort_students" {
  value = {
    for code, cohort in module.cohort : code => cohort.students
  }
  sensitive = true
}
