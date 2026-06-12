# Use tofu instead of terraform
tf := "tofu"

# Usage: just
default:
  just --list --unsorted

# Check dependencies
dependencies:
  type {{tf}}
  {{tf}} -version
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
  {{tf}} fmt -recursive

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
terramate-run-tofu command stack:
  just validate-data
  echo "Use terramate to run {{tf}} {{command}} for the {{stack}} stack"
  terramate run --tags=admin/{{stack}} -- {{tf}} {{command}}

alias terramate-run-terraform := terramate-run-tofu
alias terramate-run := terramate-run-tofu
alias tm := terramate-run-tofu

[group('cohorts')]
[working-directory: 'admin/cohorts']
cohorts-init:
  just validate-data
  {{tf}} init

[group('cohorts')]
[working-directory: 'admin/cohorts']
cohorts-validate:
  just validate-data
  {{tf}} validate

[group('cohorts')]
[working-directory: 'admin/cohorts']
cohorts-plan:
  just validate-data
  {{tf}} plan

[group('cohorts')]
[working-directory: 'admin/cohorts']
cohorts-apply:
  just validate-data
  {{tf}} apply
