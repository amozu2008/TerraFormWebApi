terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"

  backend "azurerm" {
    key = "terraform.tfstate"
    resource_group_name = "tf-blobStorage-rg"
    storage_account_name = "tfblobstorageaccount"
    container_name = "tfstate"
  }
}

variable "imagebuild" {
  type = string
  description = "latest image build"
}

provider "azurerm" {
  features {}
}



resource "azurerm_resource_group" "tf_test" {
    name = "terraFormWebApi-rg"
    location = "West Europe"
  
}

resource "azurerm_container_group" "tf_container_test" {
  name = "terraFormWebApi-container-rg"
  location = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name
  ip_address_type = "Public"
  os_type = "Linux"
  dns_name_label = "terraFormWebApi-dns-label"

  container {
    name = "joguejio-container"
    image = "judeoguejiofor927/terraformwebapi:${var.imagebuild}"
    cpu = 1
    memory = 1
    ports {
      port = 80
      protocol = "TCP"
    }
  }

}
