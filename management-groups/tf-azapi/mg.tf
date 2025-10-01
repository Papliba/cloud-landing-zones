# Root Management Group
resource "azapi_resource" "root_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.root
  parent_id = "/" # This is scope: tenant() in bicep
  body = {
    properties = {
      displayName = var.root
    }
  }
}

# Landing Zones Management Group
resource "azapi_resource" "landingzones_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.landingzones
  parent_id = "/"
  body = {
    properties = {
      details = {
        parent = {
          id = azapi_resource.root_mg.id
        }
      }
      displayName = var.landingzones
    }
  }
}

# Corp Management Group
resource "azapi_resource" "corp_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.corp
  parent_id = "/"
  body = {
    properties = {
      details = {
        parent = {
          id = azapi_resource.landingzones_mg.id
        }
      }
      displayName = var.corp
    }
  }
}

# Online Management Group
resource "azapi_resource" "online_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.online
  parent_id = "/"
  body = {
    properties = {
      details = {
        parent = {
          id = azapi_resource.landingzones_mg.id
        }
      }
      displayName = var.online
    }
  }
}

# Decommisioned Management Group
resource "azapi_resource" "decommisioned_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.decommisioned
  parent_id = "/"
  body = {
    properties = {
      details = {
        parent = {
          id = azapi_resource.root_mg.id
        }
      }
      displayName = var.decommisioned
    }
  }
}

# Sandbox Management Group
resource "azapi_resource" "sandbox_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.sandbox
  parent_id = "/"
  body = {
    properties = {
      details = {
        parent = {
          id = azapi_resource.root_mg.id
        }
      }
      displayName = var.sandbox
    }
  }
}

# Platform Management Group
resource "azapi_resource" "platform_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.platform
  parent_id = "/"
  body = {
    properties = {
      details = {
        parent = {
          id = azapi_resource.root_mg.id
        }
      }
      displayName = var.platform
    }
  }
}

# Security Management Group
resource "azapi_resource" "security_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.security
  parent_id = "/"
  body = {
    properties = {
      details = {
        parent = {
          id = azapi_resource.platform_mg.id
        }
      }
      displayName = var.security
    }
  }
}

# Management Management Group
resource "azapi_resource" "management_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.management
  parent_id = "/"
  body = {
    properties = {
      details = {
        parent = {
          id = azapi_resource.platform_mg.id
        }
      }
      displayName = var.management
    }
  }
}

# Identity Management Group
resource "azapi_resource" "identity_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.identity
  parent_id = "/"
  body = {
    properties = {
      details = {
        parent = {
          id = azapi_resource.platform_mg.id
        }
      }
      displayName = var.identity
    }
  }
}

# Connectivity Management Group
resource "azapi_resource" "connectivity_mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = var.connectivity
  parent_id = "/"
  body = {
    properties = {
      details = {
        parent = {
          id = azapi_resource.platform_mg.id
        }
      }
      displayName = var.connectivity
    }
  }
}
