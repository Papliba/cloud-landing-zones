# Bicep Loops Cheat Sheet

---

| Link | Status |
|------|--------|
| [Bicep Loops Documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/loops) | ![Status: Done](https://img.shields.io/badge/status-done-green) |

---

## Loop Syntax Examples

Bicep supports several loop constructs for iterating over ranges, collections, and objects. You can also use loops directly in resource declarations.

---

### 1. Range-based Loop

```bicep
[for i in range(startIndex, numberOfElements): {
  // loop body
}]
```
Iterates from `startIndex` for `numberOfElements` times. Useful for generating arrays or resources with numeric indices.

---

### 2. Collection-based Loop

```bicep
[for item in collection: {
  // loop body
}]
```
Iterates over each item in a collection (array).

---

### 3. Object Properties Loop

```bicep
[for item in items(object): {
  // loop body
}]
```
Iterates over each property in an object.

---

### 4. Collection with Index

```bicep
[for (item, index) in collection: {
  // loop body
}]
```
Iterates over each item and provides its index.

---

### 5. Conditional Loop

```bicep
[for item in collection: if(condition) {
  // loop body
}]
```
Includes items only if the condition is true.

---

### 6. Loop in Resource Block

You can use loops directly in resource declarations to deploy multiple resources:

```bicep
resource storageAccounts 'Microsoft.Storage/storageAccounts@2022-09-01' = [for name in storageAccountNames: {
  name: name
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}]
```
Deploys a storage account for each name in the `storageAccountNames` array.

---

### 7. Resource Loop with Index Example

You can also access the index while looping in resource blocks:

```bicep
resource storageAccountResources 'Microsoft.Storage/storageAccounts@2023-05-01' = [for (config, i) in storageConfigurations: {
  name: '${storageAccountNamePrefix}${config.suffix}${i}'
  location: resourceGroup().location
  sku: {
    name: config.sku
  }
  kind: 'StorageV2'
}]
```
Creates a storage account for each configuration, appending the index to the name.

---

### 8. Batching with `@batchSize`

Limit concurrent deployments in a resource loop: `@batchSize(n)`.

```bicep
param location string = resourceGroup().location

@batchSize(2)
resource storageAcct 'Microsoft.Storage/storageAccounts@2023-05-01' = [for i in range(0, 4): {
  name: '${i}storage${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}]
```

Notes:
- Limits concurrent iterations to `n`.
- Runs subsequent batches after current batch completes.

---
