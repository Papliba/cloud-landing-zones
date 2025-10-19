targetScope = 'subscription'

@description('tagName')
param tagName string

@description('tagValue')
param tagValue string

@description('enforcementMode')
param enforcementMode string

@description('nonComplianceMessage')
param nonComplianceMessage string

@description('location')
param location string

@description('mcf-gov-01')
module mcf_gov_01 '../resources/initiative/mcf-gov-01.bicep' = {
  scope: subscription()
  params: {
    mode : enforcementMode
    location : location
    nonComplianceMessage : nonComplianceMessage
    tagName : tagName
    tagValue : tagValue
  }
}
