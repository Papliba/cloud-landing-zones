variable "environment" {
  description = "The environment name (dev, test, nonprod, prod)"
  type        = string
  default     = "-dev"
  validation {
    condition     = contains(["-dev", "-test", "-nonprod", ""], var.environment)
    error_message = "Environment must be one of: dev, test, nonprod, prod"
  }
}
