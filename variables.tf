variable "name" {
  description = "Name for the VPN gateways"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID of the VPC to deploy in."
  type        = string
}

variable "region" {
  description = "AWS region to deploy the transit VPC in"
  type        = string
}

variable "subnets" {
  description = "List of a single or two subnets over which to evenly deploy the VPN gateways"
  type        = list(string)
}

variable "account" {
  description = "The accountname on the Aviatrix controller, under which the controller will deploy this VPC"
  type        = string
}

variable "instance_size" {
  description = "Size of the VPN gateway instances"
  type        = string
  default     = "t3.medium"
}

variable "ha_gw" {
  description = "Set to false te deploy a single spoke GW"
  type        = bool
  default     = true
}

variable "vpn_gw_count" {
  description = "The amount of VPN Gateways to be deployed"
  type        = string
  default     = 2
}

variable "vpn_cidr" {
  description = "List of subnets to be used by the VPN gateways for VPN Clients. Needs to contain enough entries for number of vpn_gw_count"
  type        = list(string)
  default     = ["10.255.254.0/24", "10.255.255.0/24"]
}

variable "vpn_split_tunnel" {
  description = "Allows default route to internet directly. Change to false if all traffic should be tunneled."
  type        = bool
  default     = true
}

variable "vpn_additional_cidrs" {
  description = "CIDR's to be routed through VPN when using split tunnelling"
  type        = string
  default     = "10.0.0.0/8,192.168.0.0/16,172.16.0.0/12"
}

variable "vpn_search_domains" {
  description = "List of DNS Domains to search"
  type        = string
  default     = ""
}

variable "vpn_name_servers" {
  description = "List of DNS Servers to use"
  type        = string
  default     = ""
}

variable "vpn_max_vpn_conn" {
  description = "Limit of concurrent users per VPN gateway"
  type        = string
  default     = "100"
}

variable "vpn_user_accelerator" {
  description = "Enable AWS Global Accelerator to optimize traffic quality"
  type        = bool
  default     = true
}

variable "vpn_saml_enabled" {
  description = "Enable SAML authentication"
  type        = bool
  default     = false
}

variable "vpn_enable_vpn_nat" {
  description = "Enable source NAT on VPN Gateways"
  type        = bool
  default     = true
}
