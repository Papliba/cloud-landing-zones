#  Bicep


 | Link | Status |
 |------|--------|
 | [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/) | ![Status: In Progress](https://img.shields.io/badge/status-in--progress-yellow) |


## Overview

### Concept
- Modules
- What if
- No state file management

### Getting started
- Installation
```bash
brew tap azure/bicep
brew install bicep
```

- Deployments cli 
```bash
az deployment tenant create --location westus --template-file main.bicep/
az deployment mg create --management-group-id mg-group-id --template-file main.bicep/
az deployment sub create --location westus --template-file main.bicep/
az deployment group create --resource-group myResourceGroup --template-file main.bicep/
```

- Deployments pwsh
```bash
New-AzManagementGroupDeployment -ManagementGroupId "mg-group-id" -Location "SwedenCentral" -TemplateFile "main.bicep"
```

> [!IMP] 
> mg name can be duplicated but not mg id

> [!NOTE]
> [Continue from here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep#about-the-language)

- DenySettingMode can not be set on mg group stack, so reources cant be locked
- Delete all resources > 

---
## Functions

> [!IMPORTANT]
[User defined functions](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/user-defined-functions)
- User defined function can only use params defined in the function.
- Functions cant use reference or list functions.
- Functions cant have default values.

```bicep
func foobar(boolPrarm bool, stringParam string) string => '${stringParam}-${stringParam}'
```

> [!NOTE]
[Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
[Api-Reference](https://learn.microsoft.com/en-us/azure/templates/)

## Overview

### Concept
- Modules
- What if
- No state file management

### Getting started
- Installation
```bash
brew tap azure/bicep
brew install bicep
```

- Deployments cli 
```bash
az deployment tenant create --location westus --template-file main.bicep/
az deployment mg create --management-group-id mg-group-id --template-file main.bicep/
az deployment sub create --location westus --template-file main.bicep/
az deployment group create --resource-group myResourceGroup --template-file main.bicep/
```

- Deployments pwsh
```bash
New-AzManagementGroupDeployment -ManagementGroupId "mg-group-id" -Location "SwedenCentral" -TemplateFile "main.bicep"
```

> [!IMP] 
> mg name can be duplicated but not mg id

> [!NOTE]
> [Continue from here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep#about-the-language)
