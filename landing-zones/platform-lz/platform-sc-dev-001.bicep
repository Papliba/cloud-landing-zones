targetScope = 'managementGroup'

@description('Subscription name to be used for the alias')
param subscriptionName string = 'platform-sc-dev-001'

@description('Management group ID to be used for the subscription')
param managementGroupId string = 

@description('Billing scope to be used for the subscription')
param billingScope string

@description('workload name to be used for the subscription')
param workload string

@description('Subscription tags')
param tags object

@description('The ID of the subscription owner')
param subscriptionOwnerId string

@description('The workload of the subscription')
param workload string = 'production'

@description('Create subscription')
resource platformSub 'Microsoft.Subscription/aliases@2024-08-01-preview' = {
  scope: managementGroup(managementGroupId)
  name: subscriptionName
  properties: {
    additionalProperties: {
      managementGroupId: managementGroupId
      subscriptionOwnerId: subscriptionOwnerId
      tags: tags
    }
    billingScope: billingScope
    displayName: subscriptionName
    workload: 'production'
  }
}
