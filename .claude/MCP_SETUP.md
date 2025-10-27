# MCP Server Setup Guide

This project uses Model Context Protocol (MCP) servers to enhance AI-assisted development with Azure-specific capabilities.

## Installed MCP Servers

### 1. Azure MCP Server
**Package**: `@azure/mcp`
**Purpose**: Provides AI agents access to Azure services including Storage, Cosmos DB, Azure CLI, and more.

**Features**:
- Azure resource management
- Azure CLI integration
- Azure service operations
- Application deployment with azd

### 2. GitHub MCP Server (Official)
**Package**: Docker image `ghcr.io/github/github-mcp-server`
**Purpose**: Official GitHub integration for repository management and operations.

**Features**:
- Repository management and code browsing
- Issue and PR automation
- GitHub Actions workflow monitoring
- Code analysis and security findings

**Required**: GitHub Personal Access Token (PAT)

### 3. Filesystem MCP Server
**Package**: `@modelcontextprotocol/server-filesystem`
**Purpose**: Secure file operations with configurable access controls.

**Features**:
- File read/write operations
- Directory browsing
- Workspace-scoped access

### 4. Memory MCP Server
**Package**: `@modelcontextprotocol/server-memory`
**Purpose**: Knowledge graph-based persistent memory system.

**Features**:
- Persistent context across sessions
- User preference memory
- Project-specific knowledge storage

**Storage**: Memory data is stored in `.claude/memory.jsonl`

## Setup Instructions

### Prerequisites

1. **Node.js**: Version 20 LTS or later
2. **Docker**: Required for GitHub MCP server
3. **Azure CLI**: For Azure MCP server authentication
4. **GitHub Personal Access Token**: For GitHub MCP server

### Installation

The MCP servers are configured in [.mcp.json](../.mcp.json) at the project root. The packages are installed globally:

```bash
npm install -g @azure/mcp@latest @modelcontextprotocol/server-filesystem @modelcontextprotocol/server-memory
```

### Required Environment Variables

Create a `.env` file or set these environment variables:

```bash
# GitHub Personal Access Token (required for GitHub MCP server)
export GITHUB_PERSONAL_ACCESS_TOKEN="your_github_pat_here"
```

#### Creating a GitHub Personal Access Token

1. Go to GitHub Settings > Developer settings > Personal access tokens > Tokens (classic)
2. Click "Generate new token (classic)"
3. Select scopes:
   - `repo` - Full control of private repositories
   - `workflow` - Update GitHub Actions workflows
   - `read:org` - Read organization data
4. Copy the token and set it as the environment variable

### Azure Authentication

The Azure MCP server uses Azure CLI authentication. Ensure you're logged in:

```bash
az login
az account set --subscription "plb-platform-nonprod-001"
```

### Verification

After setup, restart Claude Code and check MCP server status:

```bash
claude mcp list
```

Or use the `/mcp` command within Claude Code.

## Configuration

The `.mcp.json` file contains the server configurations:

- **Azure**: Uses npx to run the latest version
- **GitHub**: Uses Docker with the official GitHub image
- **Filesystem**: Scoped to workspace folder for security
- **Memory**: Stores data in `.claude/memory.jsonl`

## Troubleshooting

### GitHub MCP Server Not Connecting
- Verify Docker is running: `docker ps`
- Check GitHub PAT is set: `echo $GITHUB_PERSONAL_ACCESS_TOKEN`
- Pull the latest image: `docker pull ghcr.io/github/github-mcp-server`

### Azure MCP Server Authentication Issues
- Run `az login` to re-authenticate
- Verify subscription: `az account show`

### Filesystem Permission Errors
- The filesystem server is restricted to the workspace folder for security
- Access to parent directories is not allowed

### Memory Server Issues
- Check if `.claude/memory.jsonl` exists and is writable
- Clear memory by deleting the file if corrupted

## Security Notes

- **Never commit** your GitHub PAT or other credentials to version control
- The `.mcp.json` file uses environment variable expansion for secrets
- Filesystem access is restricted to the workspace folder
- Memory data may contain sensitive project information - add `.claude/memory.jsonl` to `.gitignore`

## Resources

- [Azure MCP Server Documentation](https://learn.microsoft.com/en-us/azure/developer/azure-mcp-server/)
- [GitHub MCP Server](https://github.com/github/github-mcp-server)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Claude Code MCP Documentation](https://docs.claude.com/en/docs/claude-code/mcp)
