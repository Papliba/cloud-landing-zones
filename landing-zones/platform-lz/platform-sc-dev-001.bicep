targetScope = 'managementGroup'

@description('Subscription name to be used for the alias')
param subscriptionName string = 'platform-sc-dev-001'

@description('Management group ID to be used for the subscription')
param managementGroupId string = 'management'

@description('Billing scope to be used for the subscription')
param billingScope string = '/providers/Microsoft.Billing/billingAccounts/6a96a13c-1f1c-5d50-b183-7c11b761cb50:77f3f15a-54f6-4f94-a3db-3a14ef57c4cf_2019-05-31'

@description('workload name to be used for the subscription')
param workload string = 'Production'

@description('Subscription tags')
param tags object = {
  environment: 'dev'
  project: 'Production'
}

@description('The ID of the subscription owner')
param subscriptionOwnerId string = 'sunny.bharne@gmail.com'

@description('Create subscription')
resource platformSub 'Microsoft.Subscription/aliases@2024-08-01-preview' = {
  scope: tenant()
  name: subscriptionName
  properties: {
    additionalProperties: {
      managementGroupId: managementGroupId
      subscriptionOwnerId: subscriptionOwnerId
      tags: tags
    }
    billingScope: billingScope
    displayName: subscriptionName
    workload: workload
  }
}
