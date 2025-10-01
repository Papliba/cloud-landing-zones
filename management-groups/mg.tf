resource "azapi_resource" "mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = "papliba-tf"
  parent_id = "/" # This is scope: tenant() in bicep
  body = {
    properties = {
      displayName = "papliba-tf"
    }
  }
}

resource "azapi_resource" "testmg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = "landing-zones-test"
  parent_id = "/" # This is scope: tenant() in bicep
  body = {
    properties = {
      details = {
        parent = {
          # id = "/providers/Microsoft.Management/managementGroups/papliba-tf" (also possible)
          id = azapi_resource.mg.id
        }
      }
      displayName = "landing-zones"
    }
  }
}
