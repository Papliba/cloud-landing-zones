targetScope = 'managementGroup'

@description('Tag enforcement Initiative')
resource mcf_gov_01 'Microsoft.Authorization/policySetDefinitions@2023-04-01' = {
  name: 'mcf_gov_1001'
  properties: {
    displayName: 'mcf_gov_1001'
    description: 'Policy set to enforce tagging on resources, resource groups, and subscriptions.'
    metadata: {
      category: 'Tags'
      version: '1.0.0'
    }
    parameters: {
      tagName: {
        type: 'String'
        metadata: {
          description: 'Name of the tag to enforce.'
        }
        defaultValue: ''
      }
      tagValue: {
        type: 'String'
        metadata: {
          description: 'Required value for the specified tag.'
       }
        defaultValue: ''
      }
    }
    policyDefinitions: [
      {
        parameters: {
          tagName: {
            value: '[parameters(\'tagName\')]'
          }
          tagValue: {
            value: '[parameters(\'tagValue\')]'
          }
        }
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
        policyDefinitionReferenceId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
      }
      {
        parameters: {
          tagName: {
            value: '[parameters(\'tagName\')]'
          }
          tagValue: {
            value: '[parameters(\'tagValue\')]'
          }
        }
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/d157c373-a6c4-483d-aaad-570756956268'
        policyDefinitionReferenceId: '/providers/Microsoft.Authorization/policyDefinitions/d157c373-a6c4-483d-aaad-570756956268'
      }
    ]
    policyType: 'custom'
  }
}
