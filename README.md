# Terraform Google Cloud Platform Associate Cloud Engineer (GCP-ACE)

The main purpose of this repository is to create resources that are mentioned within [Google Cloud Platform Associate Cloud Engineer](https://cloud.google.com/learn/certification/cloud-engineer) exam. The idea is to deploy and secure applications, services, and infrastructure, monitors operations of multiple projects, and maintains enterprise solutions to ensure target performance metrics are met.

## Development

The projects' GCP identity and resource set up, uses the environment oriented hierarchy, so one organisation contains a folder
per environment and is simple to implement. There are challenges such as deploying shared resources across multiple environments.

![Environment Oriented Hierarchy](./docs/gcloud_environment_oriented_hierarchy.png)

### Dependencies

- [gcloud](https://cloud.google.com/sdk/docs/install)
- [terraform](https://www.terraform.io/)
- [terragrunt](https://terragrunt.gruntwork.io/)
- [terraform-docs](https://terraform-docs.io/) this is required for `terraform_docs` hooks
- [pre-commit](https://pre-commit.com/)

## Prerequisites

1. Have a [Google Cloud account](https://cloud.google.com/free) account and [associated credentials](https://cloud.google.com/docs/authentication/provide-credentials-adc#how-to).

## Usage

1. Navigate to the environment you would like to deploy,
2. Initialize the configuration with:

   ```bash
   terragrunt init
   ```

3. Plan your changes with:

   ```bash
   terragrunt plan
   ```

4. If you're happy with the changes

   ```bash
   terragrunt apply
   ```

> [!NOTE]
>
> Please note that terragrunt will create a bucket for storing the remote state. Ensure the account deploying the
> resources has the appropriate permissions to create or connect to these resources.

## Pre-Commit hooks

Git hook scripts are very helpful for identifying simple issues before pushing any changes. Hooks will run on every commit automatically pointing out issues in the code e.g. trailing whitespace.

To help with the maintenance of these hooks, [pre-commit](https://pre-commit.com/) is used, along with [pre-commit-hooks](https://pre-commit.com/#install).

Please following [these instructions](https://pre-commit.com/#install) to install `pre-commit` locally and ensure that you have run `pre-commit install` to install the hooks for this project.

Additionally, once installed, the hooks can be updated to the latest available version with `pre-commit autoupdate`.

## Documentation Generation

Code formatting and documentation for `variables` and `outputs` is generated using [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/releases) hooks that in turn uses [terraform-docs](https://github.com/terraform-docs/terraform-docs) that will insert/update documentation. The following markers have been added to the `README.md`:

```
<!-- {BEGIN|END}_TF_DOCS -->
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7, <= 1.9.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.8.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.22.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.9.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.8.1 |
| <a name="provider_google"></a> [google](#provider\_google) | 7.22.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.9.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_app_engine_application.app_engine_fastapi_static_app_top_level](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/app_engine_application) | resource |
| [google_app_engine_flexible_app_version.app_engine_flexible_fastapi_static_app](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/app_engine_flexible_app_version) | resource |
| [google_app_engine_standard_app_version.app_engine_standard_fastapi_static_app](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/app_engine_standard_app_version) | resource |
| [google_artifact_registry_repository_iam_member.app_engine_gae_service_account_standard_registry_reader](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_artifact_registry_repository_iam_member.default_cloud_build_service_account_registry_writer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_cloudfunctions2_function.cloud_run_2nd_gen_fastapi_static_app](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function) | resource |
| [google_compute_network.app_engine_vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.app_engine_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_firestore_database.database](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/firestore_database) | resource |
| [google_folder.environment_folder](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder) | resource |
| [google_folder_organization_policy.folder_restrict_resource_location](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_organization_policy) | resource |
| [google_org_policy_policy.org_enforce_storage_audit_logging](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy) | resource |
| [google_org_policy_policy.project_gke_require_binary_auth](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy) | resource |
| [google_organization_iam_custom_role.iam_custom_org_iam_role_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_audit_config.project_audit](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_audit_config) | resource |
| [google_project_iam_member.app_engine_service_account_logs_writer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.app_engine_service_account_networkuser](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.app_engine_service_account_object_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.default_cloud_build_service_account_artifactregistry_writer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.default_cloud_build_service_account_bucket_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.default_cloud_build_service_account_logs_writer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.iam_custom_org_iam_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.service_account_app_engine_artifact_editor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.project_dependant_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.app_engine_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket.app_engine_zip_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.default_app_engine_service_account_admin_staging_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.default_app_engine_service_read_zip_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_object.upload_cloud_function_http_framework](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.upload_flexible_fastapi_static_app](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.upload_standard_fastapi_static_app](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_tags_tag_key.org_tag_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/tags_tag_key) | resource |
| [google_tags_tag_key.project_env_tag_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/tags_tag_key) | resource |
| [google_tags_tag_value.org_tag_value](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/tags_tag_value) | resource |
| [google_tags_tag_value.project_env_tag_value](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/tags_tag_value) | resource |
| [local_file.python_cloud_run_http_main_py](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.python_cloud_run_http_requirements](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [time_sleep.wait_30_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [archive_file.python_cloud_run_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [google_organization.org](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment type e.g. development, staging, production." | `string` | n/a | yes |
| <a name="input_gcp_billing_account"></a> [gcp\_billing\_account](#input\_gcp\_billing\_account) | The alphanumeric ID of the billing account this project belongs to. | `string` | n/a | yes |
| <a name="input_gcp_default_labels"></a> [gcp\_default\_labels](#input\_gcp\_default\_labels) | Labels that will be applied to all resources with a top level labels field or a labels<br/>field nested inside a top level metadata field. | `map(string)` | `{}` | no |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | The default project to manage resources in. | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The default region to manage resources in. | `string` | n/a | yes |
| <a name="input_gcp_zone"></a> [gcp\_zone](#input\_gcp\_zone) | The default zone to manage resources in. Generally,<br/>this zone should be within the default region you specified. | `string` | n/a | yes |
| <a name="input_organization_development_group_email_address"></a> [organization\_development\_group\_email\_address](#input\_organization\_development\_group\_email\_address) | The email address of the development team group within Google Workspace" | `string` | `""` | no |
| <a name="input_organization_domain_name"></a> [organization\_domain\_name](#input\_organization\_domain\_name) | The domain name of the Organisation" | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_engine_default_hostname"></a> [app\_engine\_default\_hostname](#output\_app\_engine\_default\_hostname) | The default hostname of the App Engine application. |
| <a name="output_app_engine_service_account_email"></a> [app\_engine\_service\_account\_email](#output\_app\_engine\_service\_account\_email) | The email address of the custom service account created for App Engine. |
| <a name="output_app_engine_standard_url"></a> [app\_engine\_standard\_url](#output\_app\_engine\_standard\_url) | The accessible URL for the standard App Engine FastAPI application (default service). |
| <a name="output_app_engine_subnetwork_gateway_address"></a> [app\_engine\_subnetwork\_gateway\_address](#output\_app\_engine\_subnetwork\_gateway\_address) | The gateway IPv4 address of the App Engine subnetwork in network.tf. |
| <a name="output_app_engine_subnetwork_ip_cidr_range"></a> [app\_engine\_subnetwork\_ip\_cidr\_range](#output\_app\_engine\_subnetwork\_ip\_cidr\_range) | The primary IPv4 address range (CIDR block) allocated to the App Engine subnetwork in network.tf. |
| <a name="output_app_engine_zip_bucket_name"></a> [app\_engine\_zip\_bucket\_name](#output\_app\_engine\_zip\_bucket\_name) | The name of the Google Cloud Storage bucket storing App Engine deployment zip archives and Cloud Function source. |
| <a name="output_cloud_run_2nd_gen_fastapi_static_app_url"></a> [cloud\_run\_2nd\_gen\_fastapi\_static\_app\_url](#output\_cloud\_run\_2nd\_gen\_fastapi\_static\_app\_url) | The HTTPS endpoint URL to access the 2nd generation Cloud Function / Cloud Run service. |
| <a name="output_gcp_project_number"></a> [gcp\_project\_number](#output\_gcp\_project\_number) | The numeric identifier of the project. |
<!-- END_TF_DOCS -->

# References

[Google Cloud Associate Cloud Engineer Course [2025] - Pass the Exam!](https://youtu.be/OlAmyf8_4O4) - [freeCodeCamp.org](https://www.youtube.com/@freecodecamp)
