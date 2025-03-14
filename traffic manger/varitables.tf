variable "pip4lb" {
  description = "Public IP Address of Region 1 Load Balancer"
  type = object({
    id = string
  })
}

variable "pip4lb_dr" {
  description = "Public IP Address of Region 2 Load Balancer"
  type = object({
    id = string
  })
}