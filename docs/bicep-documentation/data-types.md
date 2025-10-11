# Data Types

---
| Link | Status |
|------|--------|
| [Bicep Data Types](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/data-types) | ![Status: In Progress](https://img.shields.io/badge/status-in--progress-yellow) |


### Arrays
- Array bicep is immutable.
- Array can hold different types.
- Access the index in reverse `array[^1]`

#### Syntax
```bicep
var locations = [
'eastus'
'westus'
]
```

#### Methods
```bicep
empty(array)
```
- To check if an array is empty

---
### Accessor

| Link | Status |
|------|--------|
| [Bicep Index Accessor Operators](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/operators-access#index-accessor) | ![Status: Completed](https://img.shields.io/badge/status-completed-brightgreen) |


#### Access secret

```bicep
kv.getSecret('vmAdminPassword')
```

#### Access child resource properties

```bicep
resource parent 'Microsoft.Something/resourceType@2021-01-01' = {
  name: 'parentResource'
  resource child1 'Microsoft.Something/childType@2021-01-01' = {
    name: 'childResource'
  }
}

output displayName string = parent::child1.properties.displayName
```
---
