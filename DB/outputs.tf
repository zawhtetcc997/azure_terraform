output "SQL_private_endpoint_ip" {
    description = "Private Endpoint IP Adress of Primary Site"
    value = azurerm_private_endpoint.priv_end.private_service_connection[0].private_ip_address
}

output "DR_SQL_private_endpint_ip" {
    description = "Private Endpoint IP Address of DR Site"
    value = azurerm_private_endpoint.priv_end_dr.private_service_connection[0].private_ip_address
}
