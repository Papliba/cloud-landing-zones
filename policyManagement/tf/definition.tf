resource "azapi_resource" "resourceGroupName" {
  type     = "Microsoft.Resources/resourceGroups@2025-04-01"
  name     = "rg-name"
  location = "swedencentral"
}
