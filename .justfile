# Usage: just
default:
  just --list --unsorted

# Check dependencies
dependencies:
  type terraform
  terraform -version
  type terramate
  terramate version
  type pipx
  pipx --version

alias dep := dependencies
alias depend := dependencies

# Format all stacks
[group('format')]
format:
  terramate fmt
  terraform fmt -recursive

alias fmt := format
alias lint := format

# Validate cohorts.yaml against schema
[group('format')]
validate-data:
  just format
  pipx run check-jsonschema --schemafile data/schema.json data/cohorts.yaml

alias check-data := validate-data
alias check-schema := validate-data
alias validate-schema := validate-data

# Generate templates for all stacks
[group('stacks')]
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
[group('stacks')]
create-admin-stack name:
  terramate create admin/{{name}} \
    --tags "admin/{{name}}"

alias create-admin := create-admin-stack

# Use terramate to run terraform command for a stack
[group('stacks')]
terramate-run-terraform command stack:
  just validate-data
  echo "Use terramate to run terraform {{command}} for the {{stack}} stack"
  terramate run --tags=admin/{{stack}} -- terraform {{command}}

alias tm := terramate-run-terraform

[group('cohorts')]
[working-directory: 'admin/cohorts']
cohorts-init:
  just validate-data
  terraform init

[group('cohorts')]
[working-directory: 'admin/cohorts']
cohorts-validate:
  just validate-data
  terraform validate

[group('cohorts')]
[working-directory: 'admin/cohorts']
cohorts-plan:
  just validate-data
  terraform plan

[group('cohorts')]
[working-directory: 'admin/cohorts']
cohorts-apply:
  just validate-data
  terraform apply
