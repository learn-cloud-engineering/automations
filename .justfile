# Usage: just
default:
  just --list --unsorted

# Check dependencies
dependencies:
  type terraform
  terraform -version
  type terramate
  terramate version

alias dep := dependencies
alias depend := dependencies

# List all stacks
[group('list all stacks')]
list-stacks:
  terramate list

alias ls := list-stacks
alias list := list-stacks

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

# Example usage: just create-cohort 13 us-east-1
[group('create a new cohort stack')]
create-cohort number region="ap-southeast-1":
  terramate create cohorts/ce{{number}} \
    --name "Cohort {{number}}" \
    --description "Resources for CE{{number}}" \
    --after "tag:policies" \
    --tags "cohort" \
    --tags "ce{{number}}" \
    --tags "region/{{region}}"

# Example usage: just validate ce13
[group('terraform')]
[arg("tag", help="The stack's tag to target, e.g., ce13")] # Run `just --usage validate`
validate tag:
  terramate generate
  terramate run --tags={{tag}} -- terraform validate

# Example usage: just init ce13
[group('terraform')]
init tag:
  terramate generate
  terramate run --tags={{tag}} -- terraform init

# Example usage: just plan ce13
[group('terraform')]
plan tag:
  terramate generate
  terramate run --tags={{tag}} -- terraform plan

# Example usage: just apply ce13
[group('terraform')]
apply tag:
  terramate generate
  terramate run --tags={{tag}} -- terraform apply -auto-approve

# Example usage: just destroy ce13
[group('terraform')]
destroy tag:
  terramate generate
  terramate run --tags={{tag}} -- terraform destroy -auto-approve
