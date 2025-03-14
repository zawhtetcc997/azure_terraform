variable "pj_vmnic1_id" {
  description = "vmnic1 id "
}

variable "pj_vmnic2_id" {
    description = "vmnic2 id" 
}

variable "rg_name" {
    description = "Name of Resoure Group"
  
}

variable "rg_location" {
  description = "Resource Group Location"
}

variable "asvm" {
  description = "Availability Set ID for VM"
  type = string
}


#DR Variables

variable "pjdr_vmnic1_id" {
  description = "vmnic1 id "
}

variable "pjdr_vmnic2_id" {
    description = "vmnic2 id" 
}

variable "drrg_name" {
    description = "Name of Resoure Group"
  
}

variable "drrg_location" {
  description = "Resource Group Location"
}

variable "dr_asvm" {
  description = "Availability Set ID for VM"
  type = string
}
