targetScope = 'managementGroup'

// @description('EnrollmentAccount used for subscription billing')
// param enrollmentAccount string 

@description('BillingAccount used for subscription billing')
param billingAccount string = '/providers/Microsoft.Billing/billingAccounts/6a96a13c-1f1c-5d50-b183-7c11b761cb50:77f3f15a-54f6-4f94-a3db-3a14ef57c4cf_2019-05-31' 

@description('Alias to assign to the subscription')
param subscriptionAlias string = 'platform-dev-001'

@description('Workload type for the subscription')
param subscriptionWorkload string = 'Production'

resource platformSub 'Microsoft.Subscription/aliases@2020-09-01' = {
  scope: tenant()
  name: subscriptionAlias
  properties: {
    workload: subscriptionWorkload
    displayName: subscriptionAlias
    billingScope: billingAccount
  }
}

output subscriptionId string = alias.properties.subscriptionId
