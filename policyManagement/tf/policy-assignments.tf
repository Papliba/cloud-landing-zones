# ========================================
# Policy Assignments
# ========================================
locals {
  all_policy_assignments = flatten([
    for scope_folder in keys(local.mg_mapping) : [
      for file in try(fileset("${path.module}/policies/assignments/scope/${scope_folder}", "*.jsonc"), []) : {
        scope_folder       = scope_folder
        filename           = file
        assignment_name    = trimsuffix(file, ".jsonc")
        mg_id              = local.mg_mapping[scope_folder]
        assignment_content = jsondecode(file("${path.module}/policies/assignments/scope/${scope_folder}/${file}"))
      }
    ]
  ])

  policy_assignments = {
    for assignment in local.all_policy_assignments :
    "${assignment.scope_folder}-${assignment.assignment_name}" => assignment
  }
}

resource "azapi_resource" "policy_assignments" {
  for_each   = local.policy_assignments
  type       = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name       = each.value.assignment_name
  parent_id  = "/providers/Microsoft.Management/managementGroups/${each.value.mg_id}"
  depends_on = [azapi_resource.policy_definitions, azapi_resource.policy_initiatives]
  body = {
    properties = each.value.assignment_content
  }
}
