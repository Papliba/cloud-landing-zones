# Terraform Modules - Complete Guide

## What are Terraform Modules?

A Terraform module is a **container for multiple resources that are used together**. Every Terraform configuration has at least one module, called the **root module**, which consists of the resources defined in the `.tf` files in your working directory.

Think of modules as **reusable building blocks** for your infrastructure - similar to functions in programming.

## Why Use Modules?

### 1. **Reusability**
Write once, use many times. Instead of copying and pasting code, call the same module with different inputs.

### 2. **Organization**
Break complex infrastructure into logical components. Easier to understand and maintain.

### 3. **Consistency**
Ensure infrastructure is deployed the same way every time, following organizational standards.

### 4. **Collaboration**
Team members can use proven modules without understanding all implementation details.

### 5. **Version Control**
Modules can be versioned, allowing controlled updates across environments.

## Module Structure

A typical module follows this structure:

```
module-name/
├── main.tf           # Primary resource definitions
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── README.md         # Documentation
├── versions.tf       # Terraform and provider version constraints
└── examples/         # Usage examples
    └── basic/
        └── main.tf
```

### Required Files

**Minimum for a module:**
- At least one `.tf` file with resources

**Recommended:**
- `main.tf` - Main resources
- `variables.tf` - Input variables
- `outputs.tf` - Output values
- `README.md` - Documentation

## Creating Your First Module

### Example: Azure Resource Group Module

**Step 1: Create module directory**
```bash
mkdir -p modules/azure-resource-group
cd modules/azure-resource-group
```

**Step 2: Create `variables.tf`**
```hcl
variable "name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resource group"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags to apply to the resource group"
  type        = map(string)
  default     = {}
}
```

**Step 3: Create `main.tf`**
```hcl
resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
```

**Step 4: Create `outputs.tf`**
```hcl
output "id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.this.id
}

output "name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.this.location
}
```

## Using Modules

### Local Modules

```hcl
module "networking_rg" {
  source = "./modules/azure-resource-group"

  name     = "rg-networking-prod"
  location = "eastus"
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

# Access module outputs
output "networking_rg_id" {
  value = module.networking_rg.id
}
```

### Remote Modules (Git)

```hcl
module "networking_rg" {
  source = "git::https://github.com/your-org/terraform-modules.git//azure-resource-group?ref=v1.0.0"

  name     = "rg-networking-prod"
  location = "eastus"
}
```

### Terraform Registry

```hcl
module "network" {
  source  = "Azure/network/azurerm"
  version = "3.5.0"

  resource_group_name = "rg-network"
  location            = "eastus"
}
```

## Module Best Practices

### 1. **Use Clear Naming**
```hcl
# Good
module "policy_definition_enforce_tags" { }

# Avoid
module "mod1" { }
```

### 2. **Provide Sensible Defaults**
```hcl
variable "location" {
  type    = string
  default = "eastus"  # Sensible default
}

variable "environment" {
  type = string
  # No default - force user to specify
}
```

### 3. **Document Everything**
```hcl
variable "max_pods_per_node" {
  description = "Maximum number of pods per node. Affects IP planning."
  type        = number
  default     = 30
}
```

### 4. **Use Validation**
```hcl
variable "environment" {
  type        = string
  description = "Environment name"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}
```

### 5. **Output Useful Information**
```hcl
output "connection_details" {
  description = "Details needed to connect to the resource"
  value = {
    id       = azurerm_resource.this.id
    endpoint = azurerm_resource.this.endpoint
    name     = azurerm_resource.this.name
  }
}
```

### 6. **Version Your Modules**
Use semantic versioning: `v1.0.0`, `v1.1.0`, `v2.0.0`
- Major: Breaking changes
- Minor: New features (backward compatible)
- Patch: Bug fixes

### 7. **Keep Modules Focused**
One module should do one thing well. Don't create "mega modules."

```
# Good - Focused modules
modules/
├── management-group/
├── policy-definition/
└── policy-assignment/

# Avoid - Mega module
modules/
└── entire-landing-zone/  # Too much in one module
```

## Advanced Module Patterns

### Module Composition
Modules can call other modules:

```hcl
# modules/landing-zone/main.tf
module "management_groups" {
  source = "../management-group"
  # ...
}

module "policies" {
  source = "../policy-definition"

  management_group_id = module.management_groups.id
}
```

### For_each with Modules
Create multiple instances of a module:

```hcl
variable "resource_groups" {
  type = map(object({
    location = string
    tags     = map(string)
  }))
}

module "resource_groups" {
  for_each = var.resource_groups
  source   = "./modules/azure-resource-group"

  name     = each.key
  location = each.value.location
  tags     = each.value.tags
}
```

### Conditional Resources
```hcl
variable "create_nsg" {
  type    = bool
  default = true
}

resource "azurerm_network_security_group" "this" {
  count = var.create_nsg ? 1 : 0

  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}
```

## Example: Azure Policy Module

This example relates to your current project:

### Module Structure
```
modules/azure-policy-definition/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

### variables.tf
```hcl
variable "name" {
  description = "Name of the policy definition"
  type        = string
}

variable "display_name" {
  description = "Display name of the policy definition"
  type        = string
}

variable "description" {
  description = "Description of the policy definition"
  type        = string
}

variable "management_group_id" {
  description = "Management group ID where policy is defined"
  type        = string
}

variable "policy_rule" {
  description = "The policy rule in JSON format"
  type        = string
}

variable "parameters" {
  description = "Parameters for the policy definition"
  type        = string
  default     = null
}

variable "metadata" {
  description = "Metadata for the policy definition"
  type        = map(any)
  default     = {}
}
```

### main.tf
```hcl
resource "azurerm_policy_definition" "this" {
  name                = var.name
  display_name        = var.display_name
  description         = var.description
  management_group_id = var.management_group_id
  policy_type         = "Custom"
  mode                = "All"

  policy_rule = var.policy_rule
  parameters  = var.parameters

  metadata = jsonencode(var.metadata)
}
```

### outputs.tf
```hcl
output "id" {
  description = "The ID of the policy definition"
  value       = azurerm_policy_definition.this.id
}

output "name" {
  description = "The name of the policy definition"
  value       = azurerm_policy_definition.this.name
}
```

### Using the Module
```hcl
module "enforce_tag_policy" {
  source = "./modules/azure-policy-definition"

  name         = "enforce-owner-tag"
  display_name = "Enforce Owner Tag"
  description  = "Ensures all resources have an Owner tag"

  management_group_id = "plb-root"

  policy_rule = file("${path.module}/policies/definitions/enforce-owner-tag.json")

  metadata = {
    category = "Tags"
    version  = "1.0.0"
  }
}
```

## Module Sources

Terraform supports various module sources:

| Source Type | Example |
|-------------|---------|
| Local path | `./modules/my-module` |
| Git HTTPS | `git::https://github.com/org/repo.git//modules/vpc` |
| Git SSH | `git@github.com:org/repo.git//modules/vpc` |
| GitHub | `github.com/org/repo//modules/vpc` |
| Registry | `hashicorp/consul/aws` |
| S3 | `s3::https://s3.amazonaws.com/bucket/module.zip` |

## Common Pitfalls to Avoid

### 1. **Not Using Outputs**
Always output values that other modules or root config might need.

### 2. **Hardcoding Values**
```hcl
# Bad
resource "azurerm_resource_group" "this" {
  name     = "rg-prod-eastus"  # Hardcoded
  location = "eastus"
}

# Good
resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
}
```

### 3. **Over-Parameterization**
Don't create variables for everything. Find the right balance.

### 4. **Not Using `path.module`**
```hcl
# Bad - Uses working directory
locals {
  policy = file("policies/definition.json")
}

# Good - Uses module directory
locals {
  policy = file("${path.module}/policies/definition.json")
}
```

### 5. **Circular Dependencies**
Be careful when modules reference each other's outputs.

## Testing Modules

### Manual Testing
```bash
cd modules/my-module/examples/basic
terraform init
terraform plan
terraform apply
```

### Automated Testing (Terratest)
```go
func TestAzureResourceGroup(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../examples/basic",
    }

    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)

    // Assertions...
}
```

## Module Documentation Template

```markdown
# Module: azure-resource-group

## Description
Creates an Azure Resource Group with consistent naming and tagging.

## Usage
```hcl
module "example" {
  source = "./modules/azure-resource-group"

  name     = "rg-example"
  location = "eastus"
  tags     = { Environment = "dev" }
}
```

## Requirements
| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| azurerm | >= 3.0 |

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Resource group name | string | n/a | yes |
| location | Azure region | string | eastus | no |

## Outputs
| Name | Description |
|------|-------------|
| id | Resource group ID |
| name | Resource group name |

## Examples
See `examples/` directory.
```

## Next Steps

1. **Start Small**: Create a simple module for a commonly used resource
2. **Iterate**: Improve based on actual usage
3. **Document**: Good docs = happy team
4. **Version**: Tag releases when stable
5. **Test**: Validate modules work as expected
6. **Share**: Make modules available to your team

## Resources

- [Terraform Module Documentation](https://developer.hashicorp.com/terraform/language/modules)
- [Azure Verified Modules](https://aka.ms/avm)
- [Terraform Registry](https://registry.terraform.io/)
- [Module Development Best Practices](https://developer.hashicorp.com/terraform/language/modules/develop)

---

*This guide is specific to Azure Landing Zone projects but principles apply to all Terraform modules.*
