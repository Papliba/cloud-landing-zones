using '../../modules/services/platformlz.bicep'

@description('Subscription Param')
param subscriptionName = 'plb-platform-prod-001'
param managementGroupId = '/providers/Microsoft.Management/managementGroups/plb-management'
param workload = 'Production'
param billingScope = '/providers/Microsoft.Billing/billingAccounts/6a96a13c-1f1c-5d50-b183-7c11b761cb50:77f3f15a-54f6-4f94-a3db-3a14ef57c4cf_2019-05-31/billingProfiles/PX77-MIG5-BG7-PGB/invoiceSections/YGHV-3YYZ-PJA-PGB'
param tags = {
  org: 'plb'
  environment: 'prod' 
  project: 'clz'
  owner: 'sunny.bharne@gmail.com'
}
