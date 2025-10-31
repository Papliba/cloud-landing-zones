# Build and Use Modules

## Reference

https://developer.hashicorp.com/terraform/language/modules: Inprogress

## Overview

Terraform modules can be saved in Git repositories, Terraform Cloud, or cloud storage services like S3.

## Example: Git Module with Shallow Clone

```hcl
module "moduleName" {
  source   = "git::https://example.com/repo.git?ref=1.2.0&depth=1"
  for_each = toset(["dev", "staging", "prod"])

  providers = {
    azure = azure.alternate
  }

  env_name   = each.key
  depends_on = [module.network, module.database]
}
```

## Move block

## -replace=module.example.aws_instance.example

## Removed block

Continue from here: https://developer.hashicorp.com/terraform/language/modules/develop/structure
