targetScope = 'managementGroup'

@description('The Id of the parent management group.')
param rootMgName string

@description('The name of the management group.')
param mgName string

@description('child array')
param child array

@description('Root Mg')
resource rootMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: rootMgName
  properties: { 
    displayName: rootMgName
  }
}

@description('first level mg hirarchy')
resource firstLevelHirarchy 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: mgName
  properties: {
    details: { 
      parent: {
        id: rootMg.id
      }
    }
    displayName: mgName
  }
}

@description('second level mg hirarchy')
resource secondLevelHirarchy 'Microsoft.Management/managementGroups@2023-04-01' = [for mg in child: if(empty(child) == false) {
  scope: tenant()
  name: mg.name
  properties: {
    details: { 
      parent: {
        id: firstLevelHirarchy.id
      }
    }
    displayName: mg.name
  }
}]
