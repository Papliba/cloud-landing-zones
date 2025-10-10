targetScope = 'managementGroup'

@description('Subscription Name')
param subscriptionName string
param managementGroupId string
param billingScope string
param tags object
@allowed([  
  'Production'  
  'DevTest'
])
param workload string

@description('create subs')
module subCreate '../resource/sub-create.bicep' = {
  params: {
    subscriptionname : subscriptionname
    managementGroupId : managementGroupId
    billingScope : billingScope
    tags : tags
    workload : workload
  }
}
