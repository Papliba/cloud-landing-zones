targetScope = 'managementGroup'

@description('Subscription Name')
param subscriptionName string
param managementGroupId string
param billingScope string
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
    // tags : tags
    workload : workload
  }
}

// @description('create subs tag policy')
// module subCreate '../resource/sub-tags-assignments.bicep' = {
//   scope: subscription('ef4541ca-58de-411a-bed5-3127d75ee4a2')
//   params: {
//     // subscriptionName : subscriptionName
//     // managementGroupId : managementGroupId
//     // billingScope : billingScope
//     // tags : tags
//     // workload : workload
//   }
// }
