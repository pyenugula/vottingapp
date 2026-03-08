terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate15559"
    storage_account_name = "tfstate1957"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
