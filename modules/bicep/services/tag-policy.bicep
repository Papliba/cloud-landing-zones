// Module: Tag Policy Service
// Calls the tag-policy-definition module

// param policyName string
// param policyDisplayName string
// param policyDescription string
// param tagName string
// param tagValue string

module tagPolicyDefinitionModule '../resource/tag-policy-definition.bicep' = {
  name: 'tagPolicyDefinition'
  params: {
    // policyName: policyName
    // policyDisplayName: policyDisplayName
    // policyDescription: policyDescription
    // tagName: tagName
    // tagValue: tagValue
  }
}
