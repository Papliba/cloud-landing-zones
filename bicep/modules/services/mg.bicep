targetScope = 'managementGroup'

@description('org')
param orgIdentifier string = 'plbl'
param prefix string = ''

@description('variables')
var platform = 'platform'
var security = 'security'
var management = 'management'
var identity = 'identity'
var connectivity = 'connectivity'
var landingzone = 'landingzone'
var corp = 'corp'
var online = 'online'
var decommissioned = 'decommissioned'
var sandbox = 'sandbox'

@description('Mg hirarchy')
var hirarchy = [
  { 
    name: empty(prefix) ? '${orgIdentifier}-${platform}' : '${orgIdentifier}-${platform}-${prefix}'
    child: [
      { name: empty(prefix) ? '${orgIdentifier}-${security}' : '${orgIdentifier}-${security}-${prefix}' }
      { name: empty(prefix) ? '${orgIdentifier}-${management}' : '${orgIdentifier}-${management}-${prefix}' }
      { name: empty(prefix) ? '${orgIdentifier}-${identity}' : '${orgIdentifier}-${identity}-${prefix}' }
      { name: empty(prefix) ? '${orgIdentifier}-${connectivity}' : '${orgIdentifier}-${connectivity}-${prefix}' }
    ]  
  }
  { 
    name: empty(prefix) ? '${orgIdentifier}-${landingzone}' : '${orgIdentifier}-${landingzone}-${prefix}'
    child: [
      { name: empty(prefix) ? '${orgIdentifier}-${corp}' : '${orgIdentifier}-${corp}-${prefix}' }
      { name: empty(prefix) ? '${orgIdentifier}-${online}' : '${orgIdentifier}-${online}-${prefix}' }
    ]
  }
  { 
    name: empty(prefix) ? '${orgIdentifier}-${decommissioned}' : '${orgIdentifier}-${decommissioned}-${prefix}'
    child: []
  }
  { 
    name: empty(prefix) ? '${orgIdentifier}-${sandbox}' : '${orgIdentifier}-${sandbox}-${prefix}'
    child: [] 
  }
]

@description('Mg hirarchy')
module mgHirarchy '../resource/mg.bicep' = [for mg in hirarchy: {
  params: {
    rootMgName: empty(prefix) ? orgIdentifier : '${orgIdentifier}-${prefix}'
    mgName: mg.name
    child: mg.child
  }
}]
