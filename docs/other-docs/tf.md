# Tf

> [!NOTE]
[Tf](https://developer.hashicorp.com/terraform)

## Getting started
  - No project init needed just create a folder
    - Create a main.tf file
    - Create a variables.tf file
    - Create a outputs.tf file
    - Create a terraform.tfvars file
  - Commands
    - tf init -> cdktf get
    - tf plan -> what if
    - tf apply -> cdktf deploy
    - tf show -> cdktf list (to list the stacks from the state file)
    - tf output -> cdktf output (to list the outputs from the state file)
    - tf destroy -> cdktf destroy
- Folders
    - .terraform/ folder (for providers)
    - terraform.tfstate file (for state)
- Locking
  - Delete the lock file if it gets locked
  - Or terraform force-unlock Id-of-the-lock

> [!NOTE]
[Continue from here](https://developer.hashicorp.com/terraform)

# Tutorials

> [!NOTE]
[Tutorials](https://developer.hashicorp.com/tutorials/library?product=terraform)

community: https://discuss.hashicorp.com/c/terraform-core/27
github: https://github.com/hashicorp
tf Registry: https://registry.terraform.io/?product_intent=terraform
