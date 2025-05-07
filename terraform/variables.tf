variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "client_id" {
  type        = string
  description = "Service Principal client ID"
}

variable "client_secret" {
  type        = string
  description = "Service Principal client secret"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Target resource group"
}

variable "kv_name" {
  type        = string
  description = "Key Vault name"
}

variable "kv_secret_name" {
  type        = string
  description = "Name of the SSH-key secret in Key Vault"
}
