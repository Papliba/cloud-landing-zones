# variable "environment" {
#   description = "The environment name (dev, test, nonprod, prod)"
#   type        = string
#   default     = "dev"
#
#   validation {
#     condition     = contains(["dev", "test", "nonprod", "prod"], var.environment)
#     error_message = "Environment must be one of: dev, test, nonprod, prod"
#   }
# }
#
# locals {
#   # Mapping of folder names to management group ID patterns
#   mg_mapping = {
#     "root-mg"      = "plbtf-${var.environment}"
#     "landing-zone" = "plbtf-landingzone-${var.environment}"
#   }
# }
