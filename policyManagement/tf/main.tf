variable "environment" {
  description = "The environment name (dev, test, nonprod, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "test", "nonprod", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, nonprod, prod"
  }
}

locals {
  # Mapping of folder names to management group ID patterns
  mg_mapping = {
    "root-mg"      = "plbtf-${var.environment}"
    "landing-zone" = "plbtf-landingzones-${var.environment}"
  }

  # ========================================
  # Policy Definitions
  # ========================================
  all_policy_definitions = flatten([
    for scope_folder in keys(local.mg_mapping) : [
      for file in try(fileset("${path.module}/policies/definitions/scope/${scope_folder}/policies", "*.jsonc"), []) : {
        scope_folder   = scope_folder
        filename       = file
        policy_name    = trimsuffix(file, ".jsonc")
        mg_id          = local.mg_mapping[scope_folder]
        policy_content = jsondecode(file("${path.module}/policies/definitions/scope/${scope_folder}/policies/${file}"))
      }
    ]
  ])

  policy_definitions = {
    for policy in local.all_policy_definitions :
    "${policy.scope_folder}-${policy.policy_name}" => policy
  }

  # ========================================
  # Policy Initiatives (Policy Sets)
  # ========================================
  all_policy_initiatives = flatten([
    for scope_folder in keys(local.mg_mapping) : [
      for file in try(fileset("${path.module}/policies/definitions/scope/${scope_folder}/initiatives", "*.jsonc"), []) : {
        scope_folder      = scope_folder
        filename          = file
        initiative_name   = trimsuffix(file, ".jsonc")
        mg_id             = local.mg_mapping[scope_folder]
        initiative_content = jsondecode(file("${path.module}/policies/definitions/scope/${scope_folder}/initiatives/${file}"))
      }
    ]
  ])

  policy_initiatives = {
    for initiative in local.all_policy_initiatives :
    "${initiative.scope_folder}-${initiative.initiative_name}" => initiative
  }

  # ========================================
  # Policy Assignments
  # ========================================
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

# ========================================
# Deploy Policy Definitions
# ========================================
resource "azapi_resource" "policy_definitions" {
  for_each  = local.policy_definitions
  type      = "Microsoft.Authorization/policyDefinitions@2021-06-01"
  name      = each.value.policy_name
  parent_id = "/providers/Microsoft.Management/managementGroups/${each.value.mg_id}"
  body = {
    properties = each.value.policy_content
  }
}

# ========================================
# Deploy Policy Initiatives (Policy Sets)
# ========================================
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

# ========================================
# Deploy Policy Assignments
# ========================================
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
