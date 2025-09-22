targetScope = 'managementGroup'

@description('The name of the root management group.')
param root string = 'papliba-bicep'

@description('The name of the landing zone management group.')
param landingzones string = 'landing-zones'

@description('The name of the corp zone management group.')
param corp string = 'corp'

@description('The name of the online zone management group.')
param online string = 'online'

@description('The name of the decommisioned management group.')
param decommisioned string = 'decommisioned'

@description('The name of the sandbox management group.')
param sandbox string = 'sandbox'

@description('The name of the platform management group.')
param platform string = 'platform'

@description('The name of the root management group.')
resource rootMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: root
  properties: { 
    displayName: root
  }
}

@description('The name of the landing zone management group.')
resource landingzonesMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: landingzones
  properties: { 
    details: {
      parent: {
        id: rootMg.id
      }
    }
    displayName: landingzones
  }
}

@description('The name of the corp zone management group.')
resource corpMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: corp
  properties: { 
    details: {
      parent: {
        id: landingzonesMg.id
      }
    }
    displayName: corp
  }
}

@description('The name of the online zone management group.')
resource onlineMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: online
  properties: { 
    details: {
      parent: {
        id: landingzonesMg.id
      }
    }
    displayName: online
  }
}

@description('The name of the decommisioned management group.')
resource decommisionedMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: decommisioned
  properties: { 
    details: {
      parent: {
        id: rootMg.id
      }
    }
    displayName: decommisioned
  }
}

@description('The name of the sandbox management group.')
resource sandboxMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: sandbox
  properties: { 
    details: {
      parent: {
        id: rootMg.id
      }
    }
    displayName: sandbox
  }
}

@description('The name of the platform management group.')
resource platformMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  scope: tenant()
  name: platform
  properties: { 
    details: {
      parent: {
        id: rootMg.id
      }
    }
    displayName: platform
  }
}

@description('The name of the root management group.')
output rootMgName string = rootMg.name

@description('The resource ID of the root management group.')
output rootMgId string = rootMg.id

@description('The name of the landing zone management group.')
output landingzonesMgName string = landingzonesMg.name

@description('The resource ID of the landing zone management group.')
output landingzonesMgId string = landingzonesMg.id

@description('The name of the decommisioned management group.')
output decommisionedMgName string = decommisionedMg.name

@description('The resource ID of the decommisioned management group.')
output decommisionedMgId string = decommisionedMg.id

@description('The name of the sandbox management group.')
output sandboxMgName string = sandboxMg.name

@description('The resource ID of the sandbox management group.')
output sandboxMgId string = sandboxMg.id

@description('The name of the platform management group.')
output platformMgName string = platformMg.name

@description('The resource ID of the platform management group.')
output platformMgId string = platformMg.id
