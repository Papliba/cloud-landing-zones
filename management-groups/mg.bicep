targetScope = 'managementGroup'

resource mggroup 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: 'testingmggroup'
  properties: {
    // details: {
    //   parent: {
    //     id: 'string'
    //   }
    // }
    displayName: 'testingmggroup'
  }
}
