# Terragrunt will copy the Terraform files from the locations specified into this directory
terraform {
  source = "../../.."
  before_hook "checkov" {
    commands = ["apply", "plan"]
    execute  = ["checkov", "-d", ".", "--quiet", "--config-file", "${get_parent_terragrunt_dir()}/checkov.yaml"]
  }
}

locals {
  environment = "dev"
}

include {
  path = find_in_parent_folders("root.hcl")
}

# These are inputs that need to be passed for the terragrunt configuration
inputs = {
  env_prefix  = "${local.environment}"
  environment = "development"
}
