terraform {    
  required_providers {    
    azurerm = {    
      source = "hashicorp/azurerm"    
    }    
  }
  backend "azurerm" {
    ResourceGroup  = "azurepaas-rg"
    storage_account_name = "tfstatedevops"
    container_name       = "terraformgithubexample"
    key                  = "terraformgithubexample.tfstate"
  }    
}    
provider "azurerm" {    
  features {}    
}    
resource "azurerm_resource_group" "dev" {    
  name = "azurepaas-rg"    
  location = "eastus"    
}   
resource "azurerm_app_service_plan" "{AppServicePlanName}" {  
  name                = "azurepaasappserviceplan"  
  location            = "eastus"  
  resource_group_name = azurerm_resource_group.{ResourceGroup}.name  
  
  sku {  
    tier = "Free"  
    size = "F1"  
  }  
}  
  
resource "azurerm_app_service" "{WebAppName}" {  
  name                = "githubapp"  
  location            = "eastus"  
  resource_group_name = azurerm_resource_group.{ResourceGroup}.name  
  app_service_plan_id = azurerm_app_service_plan.{AppServicePlanName}.id  
  
  app_settings = {  
    "DeviceName" = "SampleDevice",  
    "DeviceId" = "2"  
  }  
}  
