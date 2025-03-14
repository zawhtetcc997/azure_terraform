variable "rg_name" {
    description = "Resource Group Name"
}

variable "rg-location" {
  description = "Resource Group Location"
}

variable "pip" {
  description = "Public IP for Load Balancer"
}

variable "vnet" {
  default = "Virtual Network"
}

variable "appip1" {
    default = "APP Server 1 IP"
}

variable "appip2" {
    default = "APP Server 2 IP"
}

variable "drrg_name" {
    description = "Resource Group Name"
}

variable "drrg-location" {
  description = "Resource Group Location"
}

variable "pipdr" {
  description = "Public IP for Load Balancer"
}

variable "drvnet" {
  default = "Virtual Network"
}

variable "drappip1" {
    default = "APP Server 1 IP"
}

variable "drappip2" {
    default = "APP Server 2 IP"
}
