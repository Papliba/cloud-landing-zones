variable "root" {
  description = "The name of the root management group."
  type        = string
  default     = "papliba-tf"
}

variable "landingzones" {
  description = "The name of the landing zone management group."
  type        = string
  default     = "landing-zones-tf"
}

variable "corp" {
  description = "The name of the corp zone management group."
  type        = string
  default     = "corp"
}

variable "online" {
  description = "The name of the online zone management group."
  type        = string
  default     = "online"
}

variable "decommisioned" {
  description = "The name of the decommisioned management group."
  type        = string
  default     = "decommisioned"
}

variable "sandbox" {
  description = "The name of the sandbox management group."
  type        = string
  default     = "sandbox"
}

variable "platform" {
  description = "The name of the platform management group."
  type        = string
  default     = "platform"
}

variable "security" {
  description = "The name of the security management group."
  type        = string
  default     = "security"
}

variable "management" {
  description = "The name of the management management group."
  type        = string
  default     = "management"
}

variable "identity" {
  description = "The name of the identity management group."
  type        = string
  default     = "identity"
}

variable "connectivity" {
  description = "The name of the connectivity management group."
  type        = string
  default     = "connectivity"
}
