terraform{
  required_providers{
    azurerm={
      source="hashicorp/azurerm"
      version= ">=3.70.0"#this version is for azurerm, NOT terraform version
    }
  }
  required_version=">=1.4.0"#this version is for Terraform Version, NOT azurerm
}

provider "azurerm"{
  features{}  
  subscription_id=var.subscription_id
  client_id=var.client_id
  client_secret=var.client_secret
  tenant_id=var.tenant_id
}

terraform {
 required_version = ">= 1.5.0"
 required_providers {
   azurerm = {
     source  = "hashicorp/azurerm"
     # Feel free to pin tighter, e.g. "~> 4.47"
     version = ">= 4.40.0, < 5.0.0"
   }
   random = {
     source  = "hashicorp/random"
     version = ">= 3.6.0"
   }
 }
}
