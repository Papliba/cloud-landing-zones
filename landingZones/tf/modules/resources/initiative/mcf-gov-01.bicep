targetScope = 'subscription'

param mode string
param location string
param nonComplianceMessage string
param tagName string
param tagValue string
// param id string = '/subscriptions/0321b3a0-df64-469b-9c1c-e29c144f5f90/resourceGroups/rg-platform-mi-wi-nonprod-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-platform-mg-wi-nonprod-001'
param id string = '/subscriptions/105027cd-ce6d-4742-9a67-ba787d5e37b8/resourceGroups/testing/providers/Microsoft.ManagedIdentity/userAssignedIdentities/test'

var initiativeName string = 'mcf-gov-01' 
var policyDescription string = 'Policy set to enforce tagging on resources, resource groups, and subscriptions.'

@description('Initiative')
resource initiative 'Microsoft.Authorization/policySetDefinitions@2023-04-01' = {
  name: '${initiativeName}-initiative'
  properties: {
    displayName: initiativeName
    description: policyDescription 
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
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${id}': {}
    }
  }
  location: location
  properties: {
    description: policyDescription
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
