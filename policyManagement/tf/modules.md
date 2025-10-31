# Build and Use Modules

## Reference

| Link                                                                                | Status |
| ----------------------------------------------------------------------------------- | ------ |
| [Build and use modules](https://developer.hashicorp.com/terraform/language/modules) |        |

## Overview

Terraform modules can be saved in Git repositories, Terraform Cloud, or cloud storage services like S3.

## Example: Git Module with Shallow Clone

```hcl
module "moduleName" {
  source   = "git::https://example.com/repo.git?ref=1.2.0&depth=1"
  for_each = toset(["dev", "staging", "prod"])

  env_name   = each.key
  depends_on = [module.network, module.database]
}
```
