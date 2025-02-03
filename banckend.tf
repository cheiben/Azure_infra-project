terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "azure1project"  //define unique name
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}