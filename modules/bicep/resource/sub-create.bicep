targetScope = 'managementGroup'

@description('Subscription Name')
param subscriptionName string
param managementGroupId string
param billingScope string
param billingProfile string
param invoiceSection string
// param tags object
@allowed([  
  'Production'  
  'DevTest'
])
param workload string

@description('Subscription Deployment')
resource sub 'Microsoft.Subscription/aliases@2021-10-01' = {
  scope: tenant()
  name: subscriptionName
  properties: {
    additionalProperties: {
      managementGroupId: managementGroupId
      // subscriptionOwnerId: 'string'
      // subscriptionTenantId: 'string'
      // tags: tags
    }
    billingScope: '/providers/Microsoft.Billing/billingAccounts/${billingScope}/billingProfiles/${billingProfile}/invoiceSections/${invoiceSection}'
    displayName: subscriptionName
    // resellerId: 'string'
    // subscriptionId: 'string'
    workload: workload
  }
}

// resource subToMG 'Microsoft.Management/managementGroups/subscriptions@2020-05-01' = {
//   scope: tenant()
//   name: '${managementGroupId}/${sub.id}'
// }
