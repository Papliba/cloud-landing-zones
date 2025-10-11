targetScope = 'subscription'

// param tags object = {
//   org: 'sonal'
//   environment: 'sonal' 
//   project: 'sonal'
//   owner: 'sonal'
// }

// var policyParams array = array(tags)

resource subTagPolicyAssignments 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
  name: 'roleassignment1'
  identity: {
    type: 'SystemAssigned'
  }
  location: 'swedencentral'
  properties: {
    description: 'description of the policy assignment'
    displayName: 'roleassignment'
    enforcementMode: 'DoNotEnforce'
    nonComplianceMessages: [
      {
        message: 'non-compliance-message-some-message'
      }
    ]
    parameters: {
      tagName: {
        value: 'owner'
      }
      tagValue: {
        value: 'rudra-bharne'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
  }
}

resource subTagPolicyAssignments2 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
  name: 'roleassignment2'
  identity: {
    type: 'SystemAssigned'
  }
  location: 'swedencentral'
  properties: {
    description: 'description of the policy assignment'
    displayName: 'roleassignment'
    enforcementMode: 'DoNotEnforce'
    nonComplianceMessages: [
      {
        message: 'non-compliance-message-some-message'
      }
    ]
    parameters: {
      tagName: {
        value: 'mother'
      }
      tagValue: {
        value: 'sonal'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
  }
}

resource subTagPolicyAssignments3 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
  name: 'roleassignment3'
  identity: {
    type: 'SystemAssigned'
  }
  location: 'swedencentral'
  properties: {
    description: 'description of the policy assignment'
    displayName: 'roleassignment'
    enforcementMode: 'DoNotEnforce'
    nonComplianceMessages: [
      {
        message: 'non-compliance-message-some-message'
      }
    ]
    parameters: {
      tagName: {
        value: 'father'
      }
      tagValue: {
        value: 'sunny'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
  }
}

resource subTagPolicyAssignments4 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
  name: 'roleassignment4'
  identity: {
    type: 'SystemAssigned'
  }
  location: 'swedencentral'
  properties: {
    description: 'description of the policy assignment'
    displayName: 'roleassignment'
    enforcementMode: 'DoNotEnforce'
    nonComplianceMessages: [
      {
        message: 'non-compliance-message-some-message'
      }
    ]
    parameters: {
      tagName: {
        value: 'father'
      }
      tagValue: {
        value: 'sunny'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
  }
}
