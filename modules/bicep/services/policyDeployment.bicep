targetScope = 'managementGroup'

@description('tags params')
param rootMg string

module tagPolicyDefinition '../resource/policy/initiative/mcf-gov-01.bicep' = {
  scope: managementGroup(rootMg)
  name: 'policyDefinitionDeployment'
}
