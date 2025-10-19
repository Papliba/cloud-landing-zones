targetScope = 'managementGroup'

@description('tags params')
param rootMg string

module tagPolicyDefinition '../resource/policy/initiative/mcf-gov-01.bicep' = {
  scope: managementGroup(rootMg)
  name: 'policyDeployment'
  resource tagPolicyAssignment 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
    name: 'policyAssignment'
    identity: {
      type: 'SystemAssigned'
    }
    location: 'swedencentral'
    properties: {
      description: 'description'
      displayName: 'display-name'
      enforcementMode: 'DoNotEnforce'
      nonComplianceMessages: [
        {
          message: 'non-compliance-message'
        }
      ]
      parameters: {
        tagName: {
          value: 'tagkey'
        }
        tagValue: {
          value: 'tagValue'
        }
      }
      policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/{policyDefinitionId}'
    }
  }
}


