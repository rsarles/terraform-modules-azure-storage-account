terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.15.0"
    }
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = "d003ea48-de34-4898-8ad4-daa31fd6479c"
  tenant_id       = "9ca75128-a244-4596-877b-f24828e476e2"

}