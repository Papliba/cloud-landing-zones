targetScope = 'subscription'

resource tagPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'tag-policy-definition'
  properties: {
    description: 'This policy ensures that specific tags and their values are applied to resources.'
    displayName: 'Enforce Specific Tags on Resources'
    mode: 'All'
    policyRule: {
      if: {
        allOf: [
            {
              field: 'type'
              exists: true
            }
          {
            anyOf: [
              {
                field: '[concat('tags[', parameters('tagName'), ']')]'
                notEquals: '[parameters('tagValue')]'
              }
              {
                field: '[concat('tags[', parameters('tagName'), ']')]'
                exists: false
              }
            ]
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
    parameters: {
      tagName: {
        type: 'String'
        metadata: {
          description: 'Name of the tag, such as "environment" or "costCenter".'
          displayName: 'Tag Name'
        }
      }
      tagValue: {
        type: 'String'
        metadata: {
          description: 'Required value for the specified tag.'
          displayName: 'Tag Value'
        }
      }
    }
  }
}

resource tagPolicyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'tag-policy-assignment'
  location: 'centralindia'
  properties: {
    displayName: 'Assignment for Tag Policy'
    description: 'Assigns the tag enforcement policy to the subscription.'
    policyDefinitionId: tagPolicyDefinition.id
    parameters: {
      tagName: {
        value: 'RudraPapliba'
      }
      tagValue: {
        value: 'RudraPapliba'
      }
    }
    enforcementMode: 'Default'
  }
}

// resource tag_policies Microsoft.Authorization/policyDefinitions@2020-03-01' = {


// param tags object = {
//   org: 'sonal'
//   environment: 'sonal' 
//   project: 'sonal'
//   owner: 'sonal'
// }

// var policyParams array = array(tags)

// resource subTagPolicyAssignments 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
//   name: 'roleassignment1' identity: {
//     type: 'SystemAssigned'
//   }
//   location: 'swedencentral'
//   properties: {
//     description: 'description of the policy assignment'
//     displayName: 'roleassignment'
//     enforcementMode: 'DoNotEnforce'
//     nonComplianceMessages: [
//       {
//         message: 'non-compliance-message-some-message'
//       }
//     ]
//     parameters: {
//       tagName: {
//         value: 'owner'
//       }
//       tagValue: {
//         value: 'rudra-bharne'
//       }
//     }
//     policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
//   }
// }
//
// resource subTagPolicyAssignments2 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
//   name: 'roleassignment2'
//   identity: {
//     type: 'SystemAssigned'
//   }
//   location: 'swedencentral'
//   properties: {
//     description: 'description of the policy assignment'
//     displayName: 'roleassignment'
//     enforcementMode: 'DoNotEnforce'
//     nonComplianceMessages: [
//       {
//         message: 'non-compliance-message-some-message'
//       }
//     ]
//     parameters: {
//       tagName: {
//         value: 'mother'
//       }
//       tagValue: {
//         value: 'sonal'
//       }
//     }
//     policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
//   }
// }
//
// resource subTagPolicyAssignments3 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
//   name: 'roleassignment3'
//   identity: {
//     type: 'SystemAssigned'
//   }
//   location: 'swedencentral'
//   properties: {
//     description: 'description of the policy assignment'
//     displayName: 'roleassignment'
//     enforcementMode: 'DoNotEnforce'
//     nonComplianceMessages: [
//       {
//         message: 'non-compliance-message-some-message'
//       }
//     ]
//     parameters: {
//       tagName: {
//         value: 'father'
//       }
//       tagValue: {
//         value: 'sunny'
//       }
//     }
//     policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
//   }
// }
//
// resource subTagPolicyAssignments4 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
//   name: 'roleassignment4'
//   identity: {
//     type: 'SystemAssigned'
//   }
//   location: 'swedencentral'
//   properties: {
//     description: 'description of the policy assignment'
//     displayName: 'roleassignment'
//     enforcementMode: 'DoNotEnforce'
//     nonComplianceMessages: [
//       {
//         message: 'non-compliance-message-some-message'
//       }
//     ]
//     parameters: {
//       tagName: {
//         value: 'father'
//       }
//       tagValue: {
//         value: 'sunny'
//       }
//     }
//     policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
//   }
// }
