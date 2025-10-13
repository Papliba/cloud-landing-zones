targetScope = 'managementGroup'

@description('Subscription Name')
param subscriptionName string
param managementGroupId string
param billingScope string
param billingProfile string
param invoiceSection string
@allowed([  
  'Production'  
  'DevTest'
])
param workload string

@description('create subs')
module subCreate '../resource/.plb.subscription.create.bicep' = {
  params: {
    subscriptionName : subscriptionName
    managementGroupId : managementGroupId
    billingScope : billingScope
    billingProfile: billingProfile
    invoiceSection: invoiceSection
    workload : workload
  }
}

output subscriptionId string = subCreate.outputs.subscriptionId
