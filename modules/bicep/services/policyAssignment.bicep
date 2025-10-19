targetScope = 'managementGroup'

@description('tags params')
param policyScope string

@description('tagName')
param tagName string = 'kfdjdskj'

@description('tagValue')
param tagValue string = 'kfdjdskj'

@description('mcf-gov-01')
module mcf_gov_01 '../resource/initiative/mcf-gov-01.bicep' = {
  scope: managementGroup(policyScope)
  params: {
    mode : 'DoNotEnforce'
    location : 'swedencentral'
    nonComplianceMessage : 'your tags are not correct'
    tagName : tagName
    tagValue : tagValue
  }
}
