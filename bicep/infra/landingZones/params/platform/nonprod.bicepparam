using '../modules/services/mg.bicep'

@description('Subscription Param')
param subscriptionName string = 'default-value'
param managementGroupId string = 'default-value'
param workload string = 'Production' // 'DevTest'

