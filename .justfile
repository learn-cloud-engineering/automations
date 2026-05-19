# Usage: just
default:
  just --list --unsorted

# Check dependencies
dependencies:
  type terraform
  terraform -version
  type terramate
  terramate version

alias check := dependencies
alias depend := dependencies


# Format all stacks
[group('format')]
format:
  terramate fmt
  terraform fmt -recursive

alias fmt := format

# Generate templates for all stacks
[group('generate templates')]
generate:
  terramate generate

alias gen := generate

# List all stacks
[group('stacks')]
list-all-stacks:
  terramate list

alias ls := list-all-stacks
alias list := list-all-stacks
alias list-stacks := list-all-stacks

# Example usage: just create-admin-stack policies
[group('stack')]
create-admin-stack name:
  terramate create admin/{{name}} \
    --tags "admin/{{name}}"

alias create-admin := create-admin-stack

# Manage cohorts
[group('cohorts')]
cohorts-generate:
  terramate generate

alias cohorts-gen := cohorts-generate

[group('cohorts')]
cohorts-validate:
  terramate run --tags=admin/cohorts -- terraform validate

[group('cohorts')]
cohorts-plan:
  terramate run --tags=admin/cohorts -- terraform plan

[group('cohorts')]
cohorts-apply:
  terramate run --tags=admin/cohorts -- terraform apply -auto-approve

[group('cohorts')]
cohorts-destroy:
  terramate run --tags=admin/cohorts -- terraform destroy
