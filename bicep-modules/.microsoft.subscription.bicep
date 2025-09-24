targetScope = 'managementGroup'

// @description('EnrollmentAccount used for subscription billing')
// param enrollmentAccount string

@description('BillingAccount used for subscription billing')
param billingAccount string

@description('Display name for the subscription')
param subscriptionDisplayName string

@description('Workload type for the subscription')
param subscriptionWorkload string

resource subscription 'Microsoft.Subscription/aliases@2020-09-01' = {
  scope: tenant()
  name: subscriptionDisplayName
  properties: {
    workload: subscriptionWorkload
    displayName: subscriptionDisplayName
    billingScope: billingAccount
    // billingScope: tenantResourceId('Microsoft.Billing/billingAccounts/enrollmentAccounts', billingAccount, enrollmentAccount)
  }
}

output subscriptionId string = subscription.properties.subscriptionId
