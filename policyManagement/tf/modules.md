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
  source = "git::https://example.com/repo.git?ref=1.2.0&depth=1"
}
```

### Parameters

- `ref` - Specifies the Git tag, branch, or commit to use
- `depth` - Limits clone history (depth=1 fetches only the latest commit)

## Creating Multiple Module Instances

### Using `count`

Create multiple identical instances of a module:

```hcl
module "servers" {
  source = "git::https://example.com/repo.git//modules/server?ref=v1.0.0&depth=1"
  count  = 3

  server_name = "server-${count.index}"
}
```

Access module outputs:

```hcl
output "server_ids" {
  value = module.servers[*].id
}
```

### Using `for_each`

Create module instances from a map or set:

```hcl
module "environments" {
  source   = "git::https://example.com/repo.git//modules/env?ref=v1.0.0&depth=1"
  for_each = toset(["dev", "staging", "prod"])

  env_name = each.key
}
```

Access module outputs:

```hcl
output "env_ids" {
  value = { for k, v in module.environments : k => v.id }
}
```
