# Cloud cohort automations — agent reference

## Project structure

```txt
├── admin/
│   ├── cohorts/       ← single stack managing all cohorts (for_each over YAML)
│   └── policies/      ← IAM policy documents (policy-documents/*.json)
├── data/
│   ├── cohorts.yaml   ← single source of truth for all cohort data
│   └── schema.json    ← JSON Schema 2020-12 for cohorts.yaml
├── modules/
│   └── cohort/        ← Terraform module (group + users + policy attachment)
└── .justfile          ← available commands (run `just --list`)
```

## Conventions

- **Cohort codes**: format `ceXX` (e.g., ce88, ce99)
- **IAM group name**: `sctp-cloud-{code}` (e.g., sctp-cloud-ce88)
- **IAM user path**: `/students/{code}/`
- **IAM user name**: the student's `aws_username` value (no cohort suffix)
- **Policy names**: derived from JSON filenames in `admin/policies/policy-documents/`
- **Scalr workspaces** (created manually): `admin-policies`, `admin-cohorts`

## Key rules

- **Do not hardcode policy names.** Use `fileset` to discover JSON files dynamically.
- **Cohort IAM policies are discovered from `admin/policies/policy-documents/`** via `fileset("...", "*.json")` and attached via `aws_iam_group_policy_attachment`.
- **Cohort status**: `active` (resources created) or `inactive` (resources destroyed).
- **Adding a new cohort**: add entry to `data/cohorts.yaml` with `status: active`, then run `just cohorts-apply`.
- **Removing a cohort**: set `status: inactive` in `data/cohorts.yaml`, run `just cohorts-apply`. Or remove the entry entirely.
- **Validate the YAML**: `just cohorts-validate-data` (checks against `data/schema.json`).

## Terraform stacks

| Stack              | Purpose                    | Tags               |
| ------------------ | -------------------------- | ------------------ |
| `admin/cohorts`    | All cohorts via YAML       | `admin/cohorts`    |
| `admin/policies`   | IAM policy documents       | `admin/policies`   |
