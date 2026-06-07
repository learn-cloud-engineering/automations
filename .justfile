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

# Run terraform command for a stack, e.g. just terraform apply stack=cohorts
[group('stacks')]
terraform command stack:
  echo "Running terraform {{command}} for the {{stack}} stack"
  terramate run --tags=admin/{{stack}} -- terraform {{command}}

alias tf := terraform

[group('cohorts')]
cohorts-init:
  just validate-data
  just terraform init cohorts

[group('cohorts')]
cohorts-validate:
  just validate-data
  just terraform validate cohorts

[group('cohorts')]
cohorts-plan:
  just validate-data
  just terraform plan cohorts

[group('cohorts')]
cohorts-apply:
  just validate-data
  just terraform apply cohorts
