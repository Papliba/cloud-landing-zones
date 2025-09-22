targetScope = 'managementGroup'

@description('The name of the management group.')
param rootMgName string = 'papliba-bicep'

// @description('The Id of the parent management group.')
// param parentId string = 'papliba-hcl'

// resource parentManagementGroup 'Microsoft.Management/managementGroups@2021-04-01' existing = {
//   name: parentId
//   scope: tenant()
// }

resource mg 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: rootMgName
  properties: { 
    // details: {
    //   parent: {
    //     id: parentManagementGroup.id
    //   }
    // }
    displayName: rootMgName
  }
}

@description('The name of the management group.')
output name string = mg.name

@description('The resource ID of the management group.')
output resourceId string = mg.id
