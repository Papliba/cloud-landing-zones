targetScope = 'managementGroup'

@description('BillingAccount used for subscription billing')
param billingScope string = '/providers/Microsoft.Billing/billingAccounts/6a96a13c-1f1c-5d50-b183-7c11b761cb50:77f3f15a-54f6-4f94-a3db-3a14ef57c4cf_2019-05-31/billingProfiles/A7DP-7SFQ-BG7-PGB/invoiceSections/Y3G3-233V-PJA-PGB'

@description('Display name for the subscription')
param subscriptionDisplayName string = 'plb-platform-dev-001'

@description('Workload type for the subscription')
param subscriptionWorkload string = 'Production'

@description('Tags to be applied to the subscription')
param tags object = {
  environment: 'test'
  project: 'platform'
}

@description('Management Group ID to which the subscription will be associated')
param managementGroupId string = 'management'

@description('Create subscription, This is one time operation')
resource subscription 'Microsoft.Subscription/aliases@2021-10-01' = {
  scope: tenant()
  name: subscriptionDisplayName
  properties: {
    workload: subscriptionWorkload
    displayName: subscriptionDisplayName
    billingScope: billingScope
    additionalProperties: {
      managementGroupId: '/providers/Microsoft.Management/managementGroups/${managementGroupId}' 
      tags: tags
    }
  }
}

output subscriptionId string = subscription.properties.subscriptionId
