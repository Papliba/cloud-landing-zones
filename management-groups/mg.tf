resource "azapi_resource" "mgTestTerraform" {
  type = "Microsoft.Management/managementGroups@2023-04-01"
  name = "mgTestingDescriptionName"
  parent_id = "string"
  body = {
    properties = {
      # details = {
      #   parent = {
      #     id = "string"
      #   }
      # }
      displayName = "terraMG"
    }
  }
}
