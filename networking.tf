resource "azurerm_virtual_network" "PJ_vnet" {
  name                = "tpj-vnet"
  location            = azurerm_resource_group.TPJ.location
  resource_group_name = azurerm_resource_group.TPJ.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "PJ"
  }
}

resource "azurerm_virtual_network" "PJDR_vnet" { #DR Section
  name                = "tpjdr-vnet"
  location            = azurerm_resource_group.TPJDR.location
  resource_group_name = azurerm_resource_group.TPJDR.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "PJDR"
  }
}


resource "azurerm_subnet" "pj_sub1" {
  name                 = "pj-sub1"
  resource_group_name  = azurerm_resource_group.TPJ.name
  virtual_network_name = azurerm_virtual_network.PJ_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "pjdr_sub1" { #DR Section
  name                 = "pjdr-sub1"
  resource_group_name  = azurerm_resource_group.TPJDR.name
  virtual_network_name = azurerm_virtual_network.PJDR_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "pj-vmnic1" {
  name                = "tpj-nic1"
  location            = azurerm_resource_group.TPJ.location
  resource_group_name = azurerm_resource_group.TPJ.name

  ip_configuration {
    name                          = "sub1"
    subnet_id                     = azurerm_subnet.pj_sub1.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "PJ"
  }
}

resource "azurerm_network_interface" "pj-vmnic2" {
  name                = "tpj-nic2"
  location            = azurerm_resource_group.TPJ.location
  resource_group_name = azurerm_resource_group.TPJ.name

  ip_configuration {
    name                          = "sub1"
    subnet_id                     = azurerm_subnet.pj_sub1.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "PJ"
  }
}

resource "azurerm_network_interface" "pjdr-vmnic1" { #DR Section
  name                = "tpjdr-nic1"
  location            = azurerm_resource_group.TPJDR.location
  resource_group_name = azurerm_resource_group.TPJDR.name

  ip_configuration {
    name                          = "drsub1"
    subnet_id                     = azurerm_subnet.pjdr_sub1.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "PJDR"
  }
}

resource "azurerm_network_interface" "pjdr-vmnic2" { #DR Section
  name                = "tpjdr-nic2"
  location            = azurerm_resource_group.TPJDR.location
  resource_group_name = azurerm_resource_group.TPJDR.name

  ip_configuration {
    name                          = "drsub1"
    subnet_id                     = azurerm_subnet.pjdr_sub1.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "PJDR"
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "pip4lb"
  location            = azurerm_resource_group.TPJ.location
  resource_group_name = azurerm_resource_group.TPJ.name
  sku                 = "Standard"
  domain_name_label = "pip4lb-tfpj"

  allocation_method       = "Static"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "PJ"
  }
}

resource "azurerm_public_ip" "pipdr" { #DR Section
  name                = "pip4lb_dr"
  location            = azurerm_resource_group.TPJDR.location
  resource_group_name = azurerm_resource_group.TPJDR.name
  sku                 = "Standard"
  domain_name_label = "pip4lb-dr-tfpj"

  allocation_method       = "Static"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "PJDR"
  }
}
