# CDKTF

> [!NOTE]
[cdktf](https://developer.hashicorp.com/terraform/cdktf)

## Getting started
### Prerequisites
```bash
brew install terraform
npm install -g cdktf-cli
cdktf init --template=typescript --local --providers=azurerm # local for local state file
npm install @cdktf/provider-azurerm # or cdktf provider add azurerm
# "terraformProviders": ["azurerm@~> 3.0"] , add the provider to the cdktf.json file 
cdktf get # to generate the provider
```

### Important commands
```bash
cdktf plan # what if
cdktf deploy 
cdktf destroy
cdktf list # to list the stacks from the state file
cdktf output # to list the outputs from the state file
```

### Important files
```bash
cdktf.json # CDKTF configuration
package.json # Node.js dependencies
src/ folder # Where your infrastructure code goes
cdktf.out # folder - Generated Terraform files
.terraform/ folder (for providers)
terraform.tfstate file (for state)
```

### If you get locked up
```bash
- Delete the lock file if it gets locked
- Or terraform force-unlock Id-of-the-lock
```

## Architecture

> [!NOTE]
  [CDKTF aws tutorial : not completed](https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-build), [CDKTF functions : not completed](https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-assets-stacks-lambda), [Deploy application : not completed](https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-applications)

> [!NOTE]
[continue from here](https://developer.hashicorp.com/terraform/cdktf)

