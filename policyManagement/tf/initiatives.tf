# ========================================
# Policy Initiatives (Policy Sets)
# ========================================
locals {
  all_policy_initiatives = flatten([
    for scope_folder in keys(local.mg_mapping) : [
      for file in try(fileset("${path.module}/policies/definitions/scope/${scope_folder}/initiatives", "*.jsonc"), []) : {
        scope_folder       = scope_folder
        filename           = file
        initiative_name    = trimsuffix(file, ".jsonc")
        mg_id              = local.mg_mapping[scope_folder]
        initiative_content = jsondecode(file("${path.module}/policies/definitions/scope/${scope_folder}/initiatives/${file}"))
      }
    ]
  ])

  policy_initiatives = {
    for initiative in local.all_policy_initiatives :
    "${initiative.scope_folder}-${initiative.initiative_name}" => initiative
  }
}

resource "azapi_resource" "policy_initiatives" {
  for_each   = local.policy_initiatives
  type       = "Microsoft.Authorization/policySetDefinitions@2021-06-01"
  name       = each.value.initiative_name
  parent_id  = "/providers/Microsoft.Management/managementGroups/${each.value.mg_id}"
  depends_on = [azapi_resource.policy_definitions]
  body = {
    properties = each.value.initiative_content
  }
}
