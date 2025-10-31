# Build and use modules

| Link                                                                                | Status |
| ----------------------------------------------------------------------------------- | ------ |
| [Build and use modules](https://developer.hashicorp.com/terraform/language/modules) |        |

## Tf modules can be saved in git , tf cloud or cloud storage like s3

module "moduleName" {
  source = "git::https://example.com/repo.git?ref=1.2.0&depth=1"
}
