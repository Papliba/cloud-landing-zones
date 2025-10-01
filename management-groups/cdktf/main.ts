import { Construct } from "constructs";
import { App, TerraformStack, TerraformVariable } from "cdktf";
import { AzurermProvider } from "@cdktf/provider-azurerm/lib/provider";
import { ManagementGroup } from "@cdktf/provider-azurerm/lib/management-group";

class ManagementGroupStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    // Provider configuration
    new AzurermProvider(this, "azurerm", {});

    // Variables
    const rootName = new TerraformVariable(this, "root", {
      type: "string",
      default: "papliba-cdktf",
      description: "The name of the root management group.",
    });

    const landingzonesName = new TerraformVariable(this, "landingzones", {
      type: "string",
      default: "landing-zones-cdktf",
      description: "The name of the landing zone management group.",
    });

    const corpName = new TerraformVariable(this, "corp", {
      type: "string",
      default: "corp-cdktf",
      description: "The name of the corp zone management group.",
    });

    const onlineName = new TerraformVariable(this, "online", {
      type: "string",
      default: "online-cdktf",
      description: "The name of the online zone management group.",
    });

    const decommisionedName = new TerraformVariable(this, "decommisioned", {
      type: "string",
      default: "decommisioned-cdktf",
      description: "The name of the decommisioned management group.",
    });

    const sandboxName = new TerraformVariable(this, "sandbox", {
      type: "string",
      default: "sandbox-cdktf",
      description: "The name of the sandbox management group.",
    });

    const platformName = new TerraformVariable(this, "platform", {
      type: "string",
      default: "platform-cdktf",
      description: "The name of the platform management group.",
    });

    const securityName = new TerraformVariable(this, "security", {
      type: "string",
      default: "security-cdktf",
      description: "The name of the security management group.",
    });

    const managementName = new TerraformVariable(this, "management", {
      type: "string",
      default: "management-cdktf",
      description: "The name of the management management group.",
    });

    const identityName = new TerraformVariable(this, "identity", {
      type: "string",
      default: "identity-cdktf",
      description: "The name of the identity management group.",
    });

    const connectivityName = new TerraformVariable(this, "connectivity", {
      type: "string",
      default: "connectivity-cdktf",
      description: "The name of the connectivity management group.",
    });

    // Root Management Group
    const rootMg = new ManagementGroup(this, "root_mg", {
      name: rootName.stringValue,
      displayName: rootName.stringValue,
    });

    // Landing Zones Management Group
    const landingzonesMg = new ManagementGroup(this, "landingzones_mg", {
      name: landingzonesName.stringValue,
      displayName: landingzonesName.stringValue,
      parentManagementGroupId: rootMg.id,
    });

    // Corp Management Group
    new ManagementGroup(this, "corp_mg", {
      name: corpName.stringValue,
      displayName: corpName.stringValue,
      parentManagementGroupId: landingzonesMg.id,
    });

    // Online Management Group
    new ManagementGroup(this, "online_mg", {
      name: onlineName.stringValue,
      displayName: onlineName.stringValue,
      parentManagementGroupId: landingzonesMg.id,
    });

    // Decommisioned Management Group
    new ManagementGroup(this, "decommisioned_mg", {
      name: decommisionedName.stringValue,
      displayName: decommisionedName.stringValue,
      parentManagementGroupId: rootMg.id,
    });

    // Sandbox Management Group
    new ManagementGroup(this, "sandbox_mg", {
      name: sandboxName.stringValue,
      displayName: sandboxName.stringValue,
      parentManagementGroupId: rootMg.id,
    });

    // Platform Management Group
    const platformMg = new ManagementGroup(this, "platform_mg", {
      name: platformName.stringValue,
      displayName: platformName.stringValue,
      parentManagementGroupId: rootMg.id,
    });

    // Security Management Group
    new ManagementGroup(this, "security_mg", {
      name: securityName.stringValue,
      displayName: securityName.stringValue,
      parentManagementGroupId: platformMg.id,
    });

    // Management Management Group
    new ManagementGroup(this, "management_mg", {
      name: managementName.stringValue,
      displayName: managementName.stringValue,
      parentManagementGroupId: platformMg.id,
    });

    // Identity Management Group
    new ManagementGroup(this, "identity_mg", {
      name: identityName.stringValue,
      displayName: identityName.stringValue,
      parentManagementGroupId: platformMg.id,
    });

    // Connectivity Management Group
    new ManagementGroup(this, "connectivity_mg", {
      name: connectivityName.stringValue,
      displayName: connectivityName.stringValue,
      parentManagementGroupId: platformMg.id,
    });
  }
}

const app = new App();
new ManagementGroupStack(app, "cdktf");
app.synth();
