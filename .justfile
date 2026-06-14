# Use tofu instead of terraform
tfcmd := "tofu"

# Usage: just
default:
  just --list --unsorted

# Check dependencies
dependencies:
  @type {{tfcmd}}
  @{{tfcmd}} -version
  @type terramate
  @terramate version
  @type pipx
  @pipx --version

alias dep := dependencies
alias depend := dependencies

# Format all stacks
[group('format')]
format:
  terramate fmt
  {{tfcmd}} fmt -recursive

alias fmt := format
alias lint := format

# Validate cohorts.yaml against schema
[group('format')]
[working-directory: 'data']
validate: format
  pipx run check-jsonschema --schemafile schema.json cohorts.yaml

alias valid := validate
alias check-data := validate
alias check-schema := validate
alias validate-data := validate
alias validate-schema := validate

# Generate templates for all stacks
[group('stacks')]
generate: validate
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
create-stack name:
  terramate create admin/{{name}} \
    --tags "admin/{{name}}"

# Use terramate to run terraform command for a stack
[group('stacks')]
terramate-run-tofu command stack:
  @echo "Use terramate to run {{tfcmd}} {{command}} for the {{stack}} stack"
  terramate run --tags=admin/{{stack}} -- {{tfcmd}} {{command}}

alias terramate-run-terraform := terramate-run-tofu
alias terramate-run := terramate-run-tofu
alias tm := terramate-run-tofu

[group('stacks')]
run-tofu-command command stack:
  {{tfcmd}} -chdir=admin/{{stack}} {{command}}

alias terraform := run-tofu-command
alias tofu := run-tofu-command
alias tf := run-tofu-command

[group('cohorts')]
[working-directory: 'admin/cohorts']
view-outputs-for-cohorts:
  {{tfcmd}} output -json

[group('cohorts')]
[working-directory: 'admin/cohorts']
student-info query:
  just view-outputs-for-cohorts | jq -r --arg q "{{query}}" '.cohort_students.value | to_entries[] | .value | to_entries[] | select(.key == $q or .value.name == $q) | "Name:       \(.value.name)", "Username:   \(.key)", "Password:   \(.value.password)", "Login URL:  \(.value.login_url)"'
