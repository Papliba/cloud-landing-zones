variable "root" {
  description = "The name of the root management group."
  type        = string
  default     = "papliba-tf-azurerm"
}

variable "landingzones" {
  description = "The name of the landing zone management group."
  type        = string
  default     = "landing-zones-tf-azurerm"
}

variable "corp" {
  description = "The name of the corp zone management group."
  type        = string
  default     = "corp-tf-azurerm"
}

variable "online" {
  description = "The name of the online zone management group."
  type        = string
  default     = "online-tf-azurerm"
}

variable "decommisioned" {
  description = "The name of the decommisioned management group."
  type        = string
  default     = "decommisioned-tf-azurerm"
}

variable "sandbox" {
  description = "The name of the sandbox management group."
  type        = string
  default     = "sandbox-tf-azurerm"
}

variable "platform" {
  description = "The name of the platform management group."
  type        = string
  default     = "platform-tf-azurerm"
}

variable "security" {
  description = "The name of the security management group."
  type        = string
  default     = "security-tf-azurerm"
}

variable "management" {
  description = "The name of the management management group."
  type        = string
  default     = "management-tf-azurerm"
}

variable "identity" {
  description = "The name of the identity management group."
  type        = string
  default     = "identity-tf-azurerm"
}

variable "connectivity" {
  description = "The name of the connectivity management group."
  type        = string
  default     = "connectivity-tf-azurerm"
}
