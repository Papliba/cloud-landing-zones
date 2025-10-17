targetScope = 'managementGroup'

@description('Subscription Name')
param subscriptionName string
param managementGroupId string
param billingScope string
param billingProfile string
param invoiceSection string

@description('Tags params')
param tagName string = 'defaultvalue'
param tagValue string = 'defaultvalue'

// param tags object
@allowed([  
  'Production'  
  'DevTest'
])
param workload string

@description('create subs')
module subCreate '../resource/sub-create.bicep' = {
  params: {
    subscriptionName : subscriptionName
    managementGroupId : managementGroupId
    billingScope : billingScope
    billingProfile: billingProfile
    invoiceSection: invoiceSection
    workload : workload
  }
}

module tagPolicyDefinitionModule '../resource/.tag-policy-definition.bicep' = {
  name: 'tagPolicyDefinition'
  params: {
    tagName: tagName
    tagValue: tagValue
  }
}
