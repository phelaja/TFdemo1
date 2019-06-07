# Thisis an example of a basic Terraform confguration file that sets up a demo resource group 
# and createes a new demo network with a public and private subnet.

# IMPORTANT: Make sure subscription_id, Clien_ID Client_secret and teneant_ID are configured!

variable "client_certificate_path" {}
variable "client_certificate_password" {}

provider "azurerm" {

  version = "=1.28.0"

  subscription_id             = "e510ba87-6b09-4b7d-bfec-869dc156ef2d"
  client_id                   = "998fad17-6b8e-4bdd-bb11-807ba9ade62b"
  client_certificate_path     = "${var.client_certificate_path}"
  client_certificate_password = "${var.client_certificate_password}"
  tenant_id                   = "7e77ab07-1bfd-4811-97ac-789496864d4c"
    
}

# Create Resource Group 
resource "azurerm_resource_group" "demo01_RG" {
    name = "demo01_resource_Group"
    location = "West US"

    tags = {
     enviornment = "demo"
     build = "demo01"
    }
 }

 # Create Virtual Network with the Resource Group 
 resource "azurerm_virtual_network" "demo01_VNet" {
     name   = "demo01_network"
     location   = "${azurerm_resource_group.demo01_RG.location}"
     resource_group_name = "${azurerm_resource_group.demo01_RG.name}"
     address_space  = ["10.0.0.0/16"]

     subnet {
         name = "demo01_public_subnet"
         address_prefix = "10.0.2.0/24"
     }

     tags = {
         Enviornment = "demo"
         build = "demo01"
     }
  }