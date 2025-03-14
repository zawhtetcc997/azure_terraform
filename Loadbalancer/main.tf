
resource "azurerm_lb" "pub-lb" {
  name                = "PRI-LB-TFPJ"
  location            = var.rg-location
  resource_group_name = var.rg_name
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = var.pip
}
}

resource "azurerm_lb_backend_address_pool" "elb-bp" {
  loadbalancer_id = azurerm_lb.pub-lb.id
  name            = "BackEndPool"
}

resource "azurerm_lb_backend_address_pool_address" "APPSVR1" {
  name                    = "APPSVR1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.elb-bp.id
  virtual_network_id      = var.vnet
  ip_address              = var.appip1
}

resource "azurerm_lb_backend_address_pool_address" "APPSVR2" {
  name                    = "APPSVR2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.elb-bp.id
  virtual_network_id      = var.vnet
  ip_address              = var.appip2
}

resource "azurerm_lb_rule" "LBR1" {
  loadbalancer_id                = azurerm_lb.pub-lb.id
  name                           = "LBRule1"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_rule" "LBR2" {
  loadbalancer_id                = azurerm_lb.pub-lb.id
  name                           = "LBRule2"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_rule" "LBR3" {
  loadbalancer_id                = azurerm_lb.pub-lb.id
  name                           = "LBRule3"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
}


######DR LB
resource "azurerm_lb" "dr-pub-lb" {
  name                = "DR-LB-TFPJ"
  location            = var.drrg-location
  resource_group_name = var.drrg_name
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = var.pipdr
}
}

resource "azurerm_lb_backend_address_pool" "drlb-bp" {
  loadbalancer_id = azurerm_lb.dr-pub-lb.id
  name            = "DRBackEndPool"
}

resource "azurerm_lb_backend_address_pool_address" "DRAPPSVR1" {
  name                    = "DRAPPSVR1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.drlb-bp.id
  virtual_network_id      = var.drvnet
  ip_address              = var.drappip1
}

resource "azurerm_lb_backend_address_pool_address" "DRAPPSVR2" {
  name                    = "DRAPPSVR2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.drlb-bp.id
  virtual_network_id      = var.drvnet
  ip_address              = var.drappip2
}

resource "azurerm_lb_rule" "DRLBR1" {
  loadbalancer_id                = azurerm_lb.dr-pub-lb.id
  name                           = "LBRule1"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_rule" "DRLBR2" {
  loadbalancer_id                = azurerm_lb.dr-pub-lb.id
  name                           = "LBRule2"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_rule" "DRLBR3" {
  loadbalancer_id                = azurerm_lb.dr-pub-lb.id
  name                           = "LBRule3"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
}
