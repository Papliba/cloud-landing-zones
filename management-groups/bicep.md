# Bicep

> [!NOTE]
[Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)

## Concept
- Modules
- What if
- No state file management

## Getting started
```bash
az bicep install
```

- Deployments 
```bash
az deployment tenant create --location westus --template-file main.bicep/
az deployment mg create --management-group-id mg-group-id --template-file main.bicep/
az deployment sub create --location westus --template-file main.bicep/
az deployment group create --resource-group myResourceGroup --template-file main.bicep/
```

> [!NOTE]
[Continue from here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep)
