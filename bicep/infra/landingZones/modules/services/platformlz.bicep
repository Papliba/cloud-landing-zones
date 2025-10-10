targetScope = 'managementGroup'

@description('Subscription Name')
param subscriptionName string = 'default-value'

param managementGroupId string = 'default-value'

@description('Subscription Deployment')
resource sub 'Microsoft.Subscription/aliases@2024-08-01-preview' = {
  scope: tenant()
  name: 'subscriptionName'
  properties: {
    additionalProperties: {
      managementGroupId: 'managementGroupId'
      // subscriptionOwnerId: 'string'
      // subscriptionTenantId: 'string'
      tags: tags
    }
    billingScope: 'string'
    displayName: 'string'
    // resellerId: 'string'
    // subscriptionId: 'string'
    workload: 'Production' # 'DevTest'
  }
}
