targetScope = 'managementGroup'

@description('tags params')
param rootMg string

module tagPolicyDefinition '../resource/.mcf-gov-1001.initiative.tags.bicep' = {
  scope: managementGroup(rootMg)
  name: 'policyDefinitionDeployment'
}
