# Cloud cohort automations

Terraform + Terramate project for managing cohort student resources.

## Tasks

- [ ] Verify GitHub usernames exist with `curl -I -X HEAD https://api.github.com/users/{{username}}`
- [ ] Test creating a cohort with students. 
- [ ] Test destroying a cohort with students by changing status to inactive.
- [ ] Test destroying a cohort with students by removing them from data/cohorts.yaml.

## Architecture

A single `data/cohorts.yaml` file is the source of truth for all cohorts.
Terraform decodes this YAML directly at plan time and creates or removes
IAM users, groups, and policy attachments for each active cohort.

## Workflow

### Adding a new cohort

1. Add the cohort to `data/cohorts.yaml` with `status: active`
2. Run `just cohorts-validate-data` to validate the YAML against the schema
3. Run `just cohorts-plan` to preview the changes
4. Run `just cohorts-apply` to create the resources

### Removing a cohort

1. Set `status: inactive` in `data/cohorts.yaml`
2. Run `just cohorts-apply` — all IAM resources for that cohort will be destroyed

### Adding a new IAM policy

1. Drop a `.json` policy document in `admin/policies/policy-documents/`
2. Apply the `admin/policies` stack to create the policy in AWS
3. Run `just cohorts-apply` — the policy is automatically attached to all active cohort groups

## Commands

Run `just --list` for all available commands. Key ones:

| Command | Description |
|---|---|
| `just cohorts-validate-data` | Validate cohorts.yaml against its JSON schema |
| `just cohorts-plan` | Preview cohort infrastructure changes |
| `just cohorts-apply` | Apply cohort infrastructure changes |
| `just cohorts-destroy` | Destroy all cohort resources |
| `just generate` | Regenerate Terramate template files |

## Project layout

```
├── admin/                 ← Terraform stacks
│   ├── cohorts/           All cohort resources
│   ├── policies/          IAM policy documents
│   └── workspaces/        Scalr workspace management
├── data/                  ← Source of truth files
│   ├── cohorts.yaml       Cohort definitions
│   └── schema.json        YAML schema for validation
└── modules/               ← Reusable Terraform modules
    └── cohort/            IAM group, users, policy attachments
```

## Validation

The `data/cohorts.yaml` file is validated against `data/schema.json`
(JSON Schema 2020-12). Run `just cohorts-validate-data` to check.
