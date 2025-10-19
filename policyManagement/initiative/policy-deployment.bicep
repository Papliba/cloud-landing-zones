targetScope = 'managementGroup'

@description('root Mg')
param rootMg string

@description('policy deployment')
module policyDeployment './mcf-gov-01.bicep' = {
  scope : managementGroup(rootMg)
}
