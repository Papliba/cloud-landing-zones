targetScope = 'managementGroup'

@description('root mg name')
var rootMgName = 'papliba'

@description('root mg id')
var rootMgId = 'papliba'

@description('first Level hirarchy')
var hirarchy = [
  { 
    name: 'Platform-test' 
    id: 'platform-test' 
    child: [
      { name: 'something-test', id: 'somethingtest' }
      { name: 'something-test1', id: 'something1test' }
      { name: 'something-test2', id: 'something2test' } 
      { name: 'somethingtest3', id: 'something3test' } 
    ] 
  }
  { 
    name: 'Landing Zones test' 
    id: 'landing-zones-test' 
    child: []
  }
  { 
    name: 'Decommisioned test' 
    id: 'decommisioned-test' 
    child: []
  }
  { 
    name: 'Sandbox-test'
    id: 'sandbox-test' 
    child: [
      { name: 'someting-test', id: 'soethingtest' }
      { name: 'someting-test1', id: 'smething1test' }
      { name: 'someting-test2', id: 'smething2test' } 
      { name: 'sometingtest3', id: 'soething3test' } 
    ] 
  }
]

@description('Mg hirarchy')
module mgHirarchy 'modules/.mg.bicep' = [for mg in hirarchy: {
  params: {
    rootMgId: rootMgId
    rootMgName: rootMgName
    mgName: mg.name
    mgId: mg.id
    child: mg.child
  }
}]
