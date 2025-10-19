targetScope = 'managementGroup'

@description('RootMg')
param rootMg string = 'plbtf'

@description('policy deployment')
module policyDeployment '../initiative/mcf-gov-01.bicep' = {
  scope : managementGroup(rootMg)
}
