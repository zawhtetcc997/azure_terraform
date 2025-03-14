resource "azurerm_mssql_server" "sqlsvr" {
    name = "tfpj-dbsvr"
    location = var.rg_location
   resource_group_name = var.rg_name
   version = "12.0"
   administrator_login = "sqladmin"
   administrator_login_password = "P@ssw0oud"
}

resource "azurerm_mssql_database" "sqldb" {
  name           = "tfpj-db"
  server_id      = azurerm_mssql_server.sqlsvr.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 32
  read_scale     = false
  sku_name       = "BC_Gen5_2"
  zone_redundant = false 

  tags = {
    environment = "PJ"
  }
}

resource "azurerm_private_endpoint" "priv_end" {
  name = "db-pri-end"
  location = var.rg_location
  resource_group_name = var.rg_name
  subnet_id = var.subnet
  
  private_service_connection {
    name = "db-end"
    private_connection_resource_id = azurerm_mssql_server.sqlsvr.id
    is_manual_connection = false
    subresource_names = [ "sqlserver" ] #need to call for services what we use
  }
}

####DR Site
resource "azurerm_mssql_server" "drsqlsvr" {
    name = "dr-tfpj-dbsvr"
    location = var.drrg_location
   resource_group_name = var.drrg_name
   version = "12.0"
   administrator_login = "sqladmin"
   administrator_login_password = "P@ssw0oud"
}

resource "azurerm_private_endpoint" "priv_end_dr" {
  name = "db-pri-end-dr"
  location = var.drrg_location
  resource_group_name = var.drrg_name
  subnet_id = var.drsubnet
  
  private_service_connection {
    name = "db-end-dr"
    private_connection_resource_id = azurerm_mssql_server.drsqlsvr.id
    is_manual_connection = false
    subresource_names = [ "sqlserver" ] #need to call for services what we use
  }
}

#SQL Replication
resource "azurerm_mssql_failover_group" "sqlfailover" {
  name      = "tfpj-sqlfailover"
  server_id = azurerm_mssql_server.sqlsvr.id
  databases = [azurerm_mssql_database.sqldb.id]

  partner_server {
    id = azurerm_mssql_server.drsqlsvr.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 80
  }
}


