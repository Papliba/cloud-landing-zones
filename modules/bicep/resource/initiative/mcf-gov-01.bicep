targetScope = 'managementGroup'

param mode string
param location string
param nonComplianceMessage string
param tagName string
param tagValue string

var initiativeName string = 'mcf-gov-01' 
var description string = 'Policy set to enforce tagging on resources, resource groups, and subscriptions.'

@description('Initiative')
resource initiative 'Microsoft.Authorization/policySetDefinitions@2023-04-01' = {
  name: '${initiativeName}-initiative'
  properties: {
    displayName: initiativeName
    description: description 
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

resource assignment 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
  name: '${initiativeName}-assignment'
  identity: {
    type: 'SystemAssigned'
  }
  location: location
  properties: {
    description: description
    displayName: '${initiativeName}-assignment'
    enforcementMode: mode 
    nonComplianceMessages: [
      {
        message: nonComplianceMessage
      }
    ]
    parameters: {
      tagName: {
        value: tagName
      }
      tagValue: {
        value: tagValue
      }
    }
    policyDefinitionId: initiative.id
  }
}
