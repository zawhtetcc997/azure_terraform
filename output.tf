output "PublicIPAddress" {
  description = "Public IP Address"
  value       = azurerm_public_ip.pip.ip_address
}

output "nic1_ip_address" {
  value = azurerm_network_interface.pj-vmnic1.ip_configuration[0].private_ip_address
}

output "nic2_ip_address" {
  value = azurerm_network_interface.pj-vmnic2.ip_configuration[0].private_ip_address
}


#DR Outputs

output "PublicIPAddress4DR" {
  description = "Public IP Address of DR"
  value       = azurerm_public_ip.pipdr.ip_address
}

output "nic1_ip_address_dr" {
  value = azurerm_network_interface.pjdr-vmnic1.ip_configuration[0].private_ip_address
}

output "nic2_ip_address_dr" {
  value = azurerm_network_interface.pjdr-vmnic2.ip_configuration[0].private_ip_address
}

