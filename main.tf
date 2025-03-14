resource "azurerm_resource_group" "TPJ" {
  name     = "TPJ_RG"
  location = "Southeast Asia"

  tags = {
    environment = "PJ"
  }
}

resource "azurerm_resource_group" "TPJDR" {
  name     = "TPJ_RG_DR"
  location = "Japan east"

  tags = {
    environment = "PJDR"
  }
}

resource "azurerm_availability_set" "tfpj-as-vm" {
  name                         = "tfpj-vmas"
  location                     = azurerm_resource_group.TPJ.location
  resource_group_name          = azurerm_resource_group.TPJ.name
  platform_update_domain_count = 1
  platform_fault_domain_count  = 1



  tags = {
    environment = "PJ"
  }
}

resource "azurerm_availability_set" "tfpjdr-as-vm" {
  name                         = "tfpjdr-vmas"
  location                     = azurerm_resource_group.TPJDR.location
  resource_group_name          = azurerm_resource_group.TPJDR.name
  platform_update_domain_count = 1
  platform_fault_domain_count  = 1



  tags = {
    environment = "PJDR"
  }
}

module "APPVM" {
  source         = "./virtualmachine"
  pj_vmnic1_id   = azurerm_network_interface.pj-vmnic1.id
  pj_vmnic2_id   = azurerm_network_interface.pj-vmnic2.id
  rg_name        = azurerm_resource_group.TPJ.name
  rg_location    = azurerm_resource_group.TPJ.location
  asvm           = azurerm_availability_set.tfpj-as-vm.id
  pjdr_vmnic1_id = azurerm_network_interface.pjdr-vmnic1.id
  pjdr_vmnic2_id = azurerm_network_interface.pjdr-vmnic2.id
  drrg_name      = azurerm_resource_group.TPJDR.name
  drrg_location  = azurerm_resource_group.TPJDR.location
  dr_asvm        = azurerm_availability_set.tfpjdr-as-vm.id
}


module "loadbalancer" {
  source        = "./Loadbalancer"
  rg_name       = azurerm_resource_group.TPJ.name
  rg-location   = azurerm_resource_group.TPJ.location
  pip           = azurerm_public_ip.pip.id
  vnet          = azurerm_virtual_network.PJ_vnet.id
  appip1        = azurerm_network_interface.pj-vmnic1.private_ip_address
  appip2        = azurerm_network_interface.pj-vmnic2.private_ip_address
  drrg_name     = azurerm_resource_group.TPJDR.name
  drrg-location = azurerm_resource_group.TPJDR.location
  pipdr         = azurerm_public_ip.pipdr.id
  drvnet        = azurerm_virtual_network.PJDR_vnet.id
  drappip1      = azurerm_network_interface.pjdr-vmnic1.private_ip_address
  drappip2      = azurerm_network_interface.pjdr-vmnic2.private_ip_address
}

module "DB" {
  source        = "./DB"
  rg_location   = azurerm_resource_group.TPJ.location
  rg_name       = azurerm_resource_group.TPJ.name
  subnet        = azurerm_subnet.pj_sub1.id
  drrg_location = azurerm_resource_group.TPJDR.location
  drrg_name     = azurerm_resource_group.TPJDR.name
  drsubnet      = azurerm_subnet.pjdr_sub1.id
}

module "trafficeManger" {
  source = "./traffic manger"
  pip4lb = {
    id = azurerm_public_ip.pip.id
  }
  pip4lb_dr = {
    id = azurerm_public_ip.pipdr.id
  }
}
