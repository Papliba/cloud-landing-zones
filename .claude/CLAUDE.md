# Cloud Landing Zones - Project Instructions

## Workflow Preferences

### Git Workflow
When I ask you to fix an issue or make changes, follow this workflow:

1. **Fix/Implement**: Make the necessary code changes
2. **Commit Changes**: Stage changes and commit with conventional commit message
3. **Push to Main**: Push changes directly to main branch

Push directly to main for all changes.

### Commit Message Format
- Use conventional commits: `fix:`, `feat:`, `docs:`, `refactor:`, `test:`, `chore:`
- Be concise but descriptive
- **DO NOT add Claude attribution or co-author tags** - commits should appear as authored solely by the user
- **DO NOT include PR numbers (e.g., #10, #11) in commit messages** - keep commit messages clean
- Examples:
  - `fix: correct policy definition syntax in enforce-naming-convention`
  - `feat: add new management group for security workloads`
  - `docs: update Azure policy documentation`

### Project Context

**Project Type**: Azure Cloud Landing Zone Infrastructure
**Primary Technologies**: Terraform, Azure Policy, Azure Management Groups
**Management Groups**: 45 groups following Azure Landing Zone pattern with "plb" prefix
**Current Subscription**: plb-platform-nonprod-001

**Key Directories**:
- `policyManagement/tf/` - Terraform configuration for Azure policies
- `policyManagement/tf/policies/definitions/scope/` - Policy definition files (JSONC format)
- `policyManagement/tf/pipelines/` - Deployment pipeline configurations

### Azure-Specific Preferences

- Use Azure CLI (`az`) commands when possible
- Reference management group hierarchy when working with policies
- Test policy definitions before deployment
- Follow Azure naming conventions (lowercase, hyphens for separation)

### Code Style

- **Terraform**: Use 2-space indentation, follow HashiCorp style guide
- **JSON/JSONC**: Use 2-space indentation
- **Comments**: Add comments for complex policy logic or infrastructure decisions
- Prefer descriptive variable names over abbreviations

### Common Tasks

**Build/Deploy**: Check `deployment-pipeline.yaml` for pipeline configuration
**Policy Management**: Policy definitions are in JSONC format in `policies/definitions/scope/`
**Testing**: Validate Terraform with `terraform validate` before committing

## Quick Reference

**MCP Servers Installed**:
- GitHub - for repo operations
- macOS Automator - for system automation
- Filesystem - for file operations
- Memory - for persistent context
- Microsoft Learn - for Azure documentation lookup

**Current Azure Context**:
- Tenant: papliba (sunnybharnegmail.onmicrosoft.com)
- User: sunny.bharne@outlook.com
- Subscription: plb-platform-nonprod-001
