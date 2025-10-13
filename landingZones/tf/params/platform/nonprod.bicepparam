using '../../../../modules/bicep/services/.lz.bicep'

@description('Subscription Param')
param subscriptionName = 'plbtf-platform-nonprod-001'
param managementGroupId = '/providers/Microsoft.Management/managementGroups/plbtf-management'
param workload = 'Production'
param billingScope = 'eb3d46c3-8f17-5f48-bc8d-c5087a895c30:d529157c-d173-4fcf-a6b5-e103d445072e_2019-05-31/'
param billingProfile = '6WY2-NPN6-BG7-PGB'
param invoiceSection = 'YPGM-C3U7-PJA-PGB'
// param tags = {
//   org: 'plb-tf'
//   environment: 'nonprod' 
//   project: 'clz'
//   owner: 'sunny.bharne@gmail.com'
// }

