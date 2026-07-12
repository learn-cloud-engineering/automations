# Cloud cohort automations

OpenTofu + Terramate project for managing cohort student resources.


## Architecture

A single `data/cohorts.yaml` file is the source of truth for all cohorts.
OpenTofu decodes this YAML directly at plan time and manages the following
per-cohort resources:

- **IAM users, groups, and policy attachments** (via `modules/cohort`)
- **VPC** (via `terraform-aws-modules/vpc/aws`)
- **S3 buckets** in `ap-southeast-1` and `us-east-1` (via `modules/bucket`)

A separate `admin/policies` stack manages customer-managed IAM policy documents
discovered from `admin/policies/policy-documents/`.

## Workflow

### Adding a new cohort

1. Add the cohort to `data/cohorts.yaml` with `status: active`
2. Run `just validate-data` to validate the YAML against the schema
3. Run `just tf plan` to preview the changes
4. Run `just tf apply` to create the resources

### Removing a cohort

1. Set `status: inactive` in `data/cohorts.yaml`
2. Run `just tf apply` — all resources for that cohort will be destroyed

### Adding a new IAM policy

1. Drop a `.json` policy document in `admin/policies/policy-documents/`
2. Run `just tf apply --stack policies` to create the policy in AWS
3. Run `just tf apply` — the policy is automatically attached to all active cohort groups

## Commands

Run `just --list` for all available commands. Key ones:

| Command | Description |
|---|---|
| `just validate` | Validate YAML schema + run `tofu validate` on all stacks |
| `just fmt` | Format all Terramate + OpenTofu files |
| `just generate` | Regenerate Terramate template files |
| `just tf plan` | Preview cohort infrastructure changes |
| `just tf apply` | Apply cohort infrastructure changes |
| `just tf destroy` | Destroy all cohort resources |
| `just tf validate` | Validate cohort configuration |
| `just tf plan --stack policies` | Preview IAM policy changes |
| `just tf apply --stack policies` | Apply IAM policy changes |

## Project layout

```
├── admin/                 ← OpenTofu stacks
│   ├── cohorts/           All cohort resources (IAM, VPC, buckets)
│   └── policies/          IAM policy documents
├── data/                  ← Source of truth files
│   ├── cohorts.yaml       Cohort definitions
│   └── schema.json        YAML schema for validation
└── modules/               ← Reusable OpenTofu modules
    ├── bucket/            S3 bucket per cohort
    └── cohort/            IAM group, users, policy attachments
```

## Validation

The `data/cohorts.yaml` file is validated against `data/schema.json`
(JSON Schema 2020-12). Run `just validate-data` to check.
