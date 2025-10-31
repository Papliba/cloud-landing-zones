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
  count = 3
}
```

### Parameters

- `ref` - Specifies the Git tag, branch, or commit to use
- `depth` - Limits clone history (depth=1 fetches only the latest commit)
- `count` - Creates multiple instances of the module (e.g., count=3 creates 3 identical instances)
