resource "azurerm_resource_group" "traffic_rg" {
    name = "Traffic-RG"
    location = "East US"
  
  tags = {
    environment = "PJ"
  }
}


resource "azurerm_traffic_manager_profile" "tfpj_traffic_profile" {
  name                   = "TFPJ-Traffic"
  resource_group_name    = azurerm_resource_group.traffic_rg.name
  traffic_routing_method = "Priority"

  dns_config {
    relative_name = "tfpj"
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTPS"
    port                         = 443
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    environment = "PJ"
  }
}

resource "azurerm_traffic_manager_azure_endpoint" "pri_end" {
  name                 = "Pri-Traffic-Endpoint"
  profile_id           = azurerm_traffic_manager_profile.tfpj_traffic_profile.id
  priority             = "1"
  weight               = 100
  target_resource_id   = var.pip4lb.id
}

resource "azurerm_traffic_manager_azure_endpoint" "dr_end" {
  name                 = "DR-Traffic-Endpoint"
  profile_id           = azurerm_traffic_manager_profile.tfpj_traffic_profile.id
  priority             = "2"
  weight               = 100
  target_resource_id   = var.pip4lb_dr.id
}