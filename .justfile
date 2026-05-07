default:
  just --list

# Check dependencies
dependencies:
  type terraform
  terraform -version
  type terramate
  terramate version

list stacks:
  terramate list

# Format and validate all stacks
@validate:
  terramate fmt
  terraform fmt -recursive
  terramate run -- terraform validate

init *tag:
  terramate generate
  terramate run --tags={{tag}} -- terraform init

generate:
  terramate generate

plan *tag:
  terramate generate
  terramate run --tags={{tag}} -- terraform plan

apply *tag:
  terramate generate
  terramate run --tags={{tag}} -- terraform apply -auto-approve

destroy *tag:
  terramate run --tags={{tag}} -- terraform destroy -auto-approve
