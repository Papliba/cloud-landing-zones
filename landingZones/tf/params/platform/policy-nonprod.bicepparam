using '../../modules/services/policy-deployment.bicep'

@description('tagName')
param tagName = 'owner'

@description('tagValue')
param tagValue = 'sunnyBharne'

@description('enforcementMode')
param enforcementMode = 'Default'

@description('nonComplianceMessage')
param nonComplianceMessage = 'your tags are not correct'

@description('location')
param location = 'swedencentral'

