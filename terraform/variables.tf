variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "client_id" {
  description = "Service Principal client ID"
  type        = string
}

variable "client_secret" {
  description = "Service Principal client secret"
  type        = string
}

variable "tenant_id" {
  description = "Service Principal tenant ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of resource group to deploy network and VM"
  type        = string
}

variable "kv_name" {
  description = "Key Vault name"
  type        = string
}

variable "kv_secret_name" {
  description = "Secret name in Key Vault containing SSH public key"
  type        = string
}

variable "kv_resource_group_name" {
  description = "Resource Group where Key Vault lives"
  type        = string
  default     = "terrabicep"
}
