# CDKTF

> [!NOTE]
[cdktf](https://developer.hashicorp.com/terraform/cdktf)

## Getting started
### Prerequisites
- TypeScript
- Node.js
```bash
brew install terraform
npm install -g cdktf-cli
cdktf init --template=typescript --local --providers=azurerm # local for local state file
npm install @cdktf/provider-azurerm # or cdktf provider add azurerm
# "terraformProviders": ["azurerm@~> 3.0"] , add the provider to the cdktf.json file 
cdktf get # to generate the provider
```

### Important commands
```bash
cdktf plan # what if
cdktf synth # generate the terraform json files --hcl flag for hcl files
cdktf convert --from-hcl main.tf
cdktf deploy 
cdktf destroy
cdktf list # to list the stacks from the state file
cdktf output # to list the outputs from the state file
```

### Important files
```bash
cdktf.json # CDKTF configuration
package.json # Node.js dependencies
src/ folder # Where your infrastructure code goes
cdktf.out # folder - Generated Terraform files
.terraform/ folder (for providers)
terraform.tfstate file (for state)
```

### If you get locked up
```bash
- Delete the lock file if it gets locked
- Or terraform force-unlock Id-of-the-lock
```

## Architecture
- Constrcut: parent class, represents a state of the infrastructure
    - App: class, one or more apps per project
    - Stack: class, each stack is a separate terraform directory
    - Resources: class, multiple resources per stack
        - Contruct is like a terraform module but more powerful
        - Constructs can build complex resources that can be used as other providers supplied resources
        - Contructs allows strict type checking
        - Constructs can be used to codify best practices accross the organization
        - Constructs can be tested like any other tool
    - Types of constructs
        - L1 (low level) - directly map to terraform resources
        - L2 (high level) - abstract away some of the complexity of the underlying terraform resource
        - L3 (patterns) - encapsulate best practices and can include multiple L2 and L1 constructs
    - custom construct: https://github.com/skorfmann/cdktf-hybrid-module/blob/7a84cbea62fbc3c3b7e92c00d75fcaad495cf29b/packages/cdktf-hybrid-module/lib/construct.ts
    - Constructs can also create, manage and validate resources outside the construct as apossed to tf.
    - build complex resources.
    - Provides strict type checking, this is not possible in tf.
    - can codify best practices across the organization.

> [!NOTE]
[Construct: Read again](https://developer.hashicorp.com/terraform/cdktf/concepts/constructs)

- Providers
    - Plugin that use to call the external api
    - Install cdk tf provider from here
       - [Construt hub](https://constructs.dev/)
    - providets needs to be added to the cdktf.json file 
        ```json
        {
          "language": "typescript",
          "app": "npx ts-node main.ts",
          "terraformProviders": [
            "azurerm@~> 4.0.0"
          ],
          "codeMakerOutput": "imports",
          "projectId": "your-project-id"
        }
        ```
    - After this addition run cdktf get to install all the packages needed
    - After that you are ready to import those classes in your main.ts file
    - Provider caching
       - This is important when you dont want to download the provider every time you do synth
- Resource 
    - You can import resources using below 
    - new S3Bucket(this, "bucket", {}).importFrom(bucketId);
    - There are some problems with importing the resoruces in cdktf but you need to check that later 
    - Generate configuration for import 
    - S3Bucket.generateConfigForImport(this, "bucket", bucketId);
- Project setup
    - cdktf init --local (Saves the state file locally, If not the state file will be saved in the hcp terraform) 

:::tip[Training!]
- [Continue-from-here](https://developer.hashicorp.com/terraform/cdktf/concepts/resources)
:::

> [!NOTE]
  [CDKTF aws tutorial : not completed](https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-build), [CDKTF functions : not completed](https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-assets-stacks-lambda), [Deploy application : not completed](https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-applications)

> [!NOTE]
[continue from here](https://developer.hashicorp.com/terraform/cdktf/concepts/constructs)

