# Cloud Landing Zones

A TypeScript-based infrastructure as code project using CDKTF (Cloud Development Kit for Terraform) to manage cloud landing zones with Azure provider support.

## 🏗️ Overview

This project provides a foundation for building and managing cloud landing zones using modern infrastructure as code practices. It leverages CDKTF to create type-safe, testable infrastructure definitions that can be deployed across different cloud environments.

## 🚀 Features

- **TypeScript-based Infrastructure**: Type-safe infrastructure definitions with full IDE support
- **CDKTF Integration**: Leverages HashiCorp's CDKTF for enhanced developer experience
- **Azure Provider Support**: Pre-configured with Azure Resource Manager provider
- **Testing Framework**: Jest-based testing setup for infrastructure validation
- **Documentation**: Comprehensive guides for CDKTF, Bicep, and Terraform
- **Local State Management**: Configured for local state file management

## 📋 Prerequisites

- **Node.js**: Version 20.9 or higher
- **TypeScript**: For type-safe development
- **Terraform**: For infrastructure provisioning
- **Azure CLI**: For Azure authentication and deployment

## 🛠️ Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd cloud-landing-zones
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Install CDKTF CLI globally**:
   ```bash
   npm install -g cdktf-cli
   ```

4. **Install Terraform** (macOS):
   ```bash
   brew install terraform
   ```

5. **Generate provider bindings**:
   ```bash
   npm run get
   ```

## 🏃‍♂️ Quick Start

1. **Compile the TypeScript code**:
   ```bash
   npm run compile
   ```

2. **Synthesize Terraform configuration**:
   ```bash
   cdktf synth
   ```

3. **Plan your infrastructure changes**:
   ```bash
   cdktf plan
   ```

4. **Deploy your infrastructure**:
   ```bash
   cdktf deploy
   ```

## 📁 Project Structure

```
cloud-landing-zones/
├── __tests__/              # Test files
│   └── main-test.ts        # Main test suite
├── docs/                   # Documentation
│   ├── bicep.md           # Bicep documentation
│   ├── cdktf.md           # CDKTF documentation
│   ├── tf.md              # Terraform documentation
│   └── certs/             # Certificate documentation
├── cdktf.out/             # Generated Terraform files
├── main.ts                # Main application entry point
├── cdktf.json             # CDKTF configuration
├── package.json           # Node.js dependencies
├── tsconfig.json          # TypeScript configuration
├── jest.config.js         # Jest testing configuration
└── setup.js               # Jest setup file
```

## 🔧 Available Scripts

| Command | Description |
|---------|-------------|
| `npm run get` | Import/update Terraform providers and modules |
| `npm run build` | Compile TypeScript code |
| `npm run compile` | Compile TypeScript with pretty output |
| `npm run watch` | Watch for changes and compile TypeScript |
| `npm run synth` | Synthesize Terraform resources |
| `npm run test` | Run unit tests |
| `npm run test:watch` | Watch and rerun tests on changes |
| `npm run upgrade` | Upgrade CDKTF to latest version |
| `npm run upgrade:next` | Upgrade CDKTF to latest @next version |

## 🎯 CDKTF Commands

| Command | Description |
|---------|-------------|
| `cdktf synth [stack]` | Synthesize Terraform resources to cdktf.out/ |
| `cdktf plan [stack]` | Perform a diff (terraform plan) for the given stack |
| `cdktf deploy [stack]` | Deploy the given stack |
| `cdktf destroy [stack]` | Destroy the stack |
| `cdktf list` | List stacks from the state file |
| `cdktf output` | List outputs from the state file |

## 🧪 Testing

The project includes a comprehensive testing setup using Jest:

```bash
# Run all tests
npm run test

# Run tests in watch mode
npm run test:watch
```

Tests are located in the `__tests__/` directory and can validate:
- Resource creation and configuration
- Terraform configuration validity
- Infrastructure planning success

## 📚 Documentation

The `docs/` directory contains detailed guides for:

- **[CDKTF Guide](docs/cdktf.md)**: Comprehensive CDKTF setup, concepts, and best practices
- **[Bicep Guide](docs/bicep.md)**: Azure Bicep deployment strategies
- **[Terraform Guide](docs/tf.md)**: Traditional Terraform workflows
- **[Tutorials](tutorials.md)**: Additional learning resources

## 🔐 Configuration

### CDKTF Configuration (`cdktf.json`)

The project is configured with:
- **Language**: TypeScript
- **Provider**: Azure Resource Manager (`azurerm@~> 3.0`)
- **Local State**: State file managed locally
- **Project ID**: Unique identifier for CDKTF tracking

### Azure Authentication

Ensure you're authenticated with Azure:

```bash
az login
az account set --subscription "your-subscription-id"
```

## 🏗️ Architecture

The project follows CDKTF's construct-based architecture:

- **App**: Top-level application container
- **Stack**: Represents a Terraform workspace
- **Constructs**: Reusable infrastructure components
  - **L1 (Low-level)**: Direct Terraform resource mappings
  - **L2 (High-level)**: Abstracted resources with simplified APIs
  - **L3 (Patterns)**: Best practice implementations

## 🚨 Troubleshooting

### Common Issues

1. **Provider Lock Issues**:
   ```bash
   # Delete lock file if stuck
   rm .terraform.lock.hcl
   
   # Or force unlock
   terraform force-unlock <lock-id>
   ```

2. **State File Issues**:
   - The project uses local state management
   - State file is stored as `terraform.tfstate`

3. **Provider Caching**:
   - Providers are cached to avoid repeated downloads
   - Clear cache if experiencing issues: `rm -rf .terraform/`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the Mozilla Public License 2.0 (MPL-2.0).

## 🔗 Useful Links

- [CDKTF Documentation](https://developer.hashicorp.com/terraform/cdktf)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Documentation](https://developer.hashicorp.com/terraform)
- [Construct Hub](https://constructs.dev/) - CDKTF provider marketplace

## 📞 Support

For questions and support:
- Check the documentation in the `docs/` directory
- Review the test examples in `__tests__/`
- Consult the CDKTF and Terraform official documentation

---

**Note**: This project is configured for local development and testing. For production deployments, consider implementing proper state management, CI/CD pipelines, and security best practices.

