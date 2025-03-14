
resource "azurerm_linux_virtual_machine" "tpj-vm1" {
  name                = "APP-SVR1"
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password = "P@ssw0rd2024"
  disable_password_authentication = false
  availability_set_id = var.asvm
  network_interface_ids = [
  var.pj_vmnic1_id,
  ]

   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "PJ"
  }
}


resource "azurerm_linux_virtual_machine" "tpj-vm2" {
  name                = "APP-SVR2"
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password = "P@ssw0rd2024"
  disable_password_authentication = false
  availability_set_id = var.asvm
  network_interface_ids = [
    var.pj_vmnic2_id,
  ]

   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "PJ"
  }
}


#DR VMs

resource "azurerm_linux_virtual_machine" "tpjdr-vm1" {
  name                = "APP-SVR1-DR"
  resource_group_name = var.drrg_name
  location            = var.drrg_location
  size                = "Standard_B4ms"
  admin_username      = "adminuser"
  admin_password = "P@ssw0rd2024"
  disable_password_authentication = false
  availability_set_id = var.dr_asvm
  network_interface_ids = [
  var.pjdr_vmnic1_id,
  ]

   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "PJDR"
  }
}


resource "azurerm_linux_virtual_machine" "tpjdr-vm2" {
  name                = "APP-SVR2-DR"
  resource_group_name = var.drrg_name
  location            = var.drrg_location
  size                = "Standard_B4ms"
  admin_username      = "adminuser"
  admin_password = "P@ssw0rd2024"
  disable_password_authentication = false
  availability_set_id = var.dr_asvm
  network_interface_ids = [
    var.pjdr_vmnic2_id,
  ]

   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "PJDR"
  }
}