# Cloud Landing Zones

TypeScript infrastructure as code using CDKTF for Azure cloud landing zones.

## Notes

- [CDKTF](docs/cdktf.md)
- [Bicep](docs/bicep.md)
- [Terraform](docs/tf.md)

## Overview

CDKTF-based infrastructure for cloud landing zones with Azure provider support.

## Features

- TypeScript infrastructure definitions
- CDKTF integration
- Azure provider support
- Jest testing framework
- Local state management

## Prerequisites

- Node.js 20.9+
- TypeScript
- Terraform
- Azure CLI

## Installation

```bash
git clone <repository-url>
cd cloud-landing-zones
npm install
npm install -g cdktf-cli
brew install terraform
npm run get
```

## Quick Start

```bash
npm run compile
cdktf synth
cdktf plan
cdktf deploy
```

## Project Structure

```
cloud-landing-zones/
├── __tests__/              # Test files
├── docs/                   # Documentation
├── cdktf.out/             # Generated Terraform files
├── main.ts                # Main application entry point
├── cdktf.json             # CDKTF configuration
└── package.json           # Node.js dependencies
```

## Scripts

- `npm run get` - Import/update Terraform providers
- `npm run build` - Compile TypeScript
- `npm run compile` - Compile with pretty output
- `npm run watch` - Watch for changes
- `npm run synth` - Synthesize Terraform resources
- `npm run test` - Run unit tests
- `npm run test:watch` - Watch tests
- `npm run upgrade` - Upgrade CDKTF

## CDKTF Commands

- `cdktf synth [stack]` - Synthesize Terraform resources
- `cdktf plan [stack]` - Plan changes
- `cdktf deploy [stack]` - Deploy stack
- `cdktf destroy [stack]` - Destroy stack
- `cdktf list` - List stacks
- `cdktf output` - List outputs

## Testing

```bash
npm run test
npm run test:watch
```

## Configuration

### CDKTF Configuration (`cdktf.json`)

- Language: TypeScript
- Provider: Azure Resource Manager (`azurerm@~> 3.0`)
- Local State: State file managed locally

### Azure Authentication

```bash
az login
az account set --subscription "your-subscription-id"
```

## Architecture

- **App**: Top-level application container
- **Stack**: Terraform workspace
- **Constructs**: Reusable infrastructure components
  - **L1**: Direct Terraform resource mappings
  - **L2**: Abstracted resources
  - **L3**: Best practice implementations

## Troubleshooting

**Provider Lock Issues**:

```bash
rm .terraform.lock.hcl
terraform force-unlock <lock-id>
```

**State File**: Stored as `terraform.tfstate`

**Provider Caching**: Clear with `rm -rf .terraform/`

## contributing

1. Fork repository
2. Create feature branch
3. Make changes
4. Add tests
5. Submit pull request

## License

Mozilla Public License 2.0 (MPL-2.0)

## Links

- [CDKTF Documentation](https://developer.hashicorp.com/terraform/cdktf)
- [Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Documentation](https://developer.hashicorp.com/terraform)
- [Construct Hub](https://constructs.dev/)
