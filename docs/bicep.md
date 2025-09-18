# Bicep

> [!NOTE]
[Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)

## Concept
- Modules
- What if
- No state file management

## Getting started
- az bicep install
- az deployment group create --resource-group myResourceGroup --template-file main.bicep
- No statefile, state is managed by azure in form of deployments and stocks
  - Scope
    - Management Group: az deployment mg create --management-group-id "" --template-file main.bicep/ template file
    - Subscription: az deployment sub create --location westus --template-file main.bicep
    - Resource Group: az deployment group create --resource-group myResourceGroup --template-file main.bicep
    - Tenant: az deployment tenant create --location westus --template-file main.bicep


> [!NOTE]
[Continue from here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep)

