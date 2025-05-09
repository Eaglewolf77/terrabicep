terraform {
  backend "azurerm" {
    resource_group_name  = "terrabicep-terraform"
    storage_account_name = "terrabicepstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.kv_resource_group_name
}

data "azurerm_key_vault_secret" "sshkey" {
  name         = var.kv_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

# … resten of your resources …
