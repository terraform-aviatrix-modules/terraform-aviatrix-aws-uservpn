output "vpc" {
  description = "The created VPC as an object with all of it's attributes. This was created using the aviatrix_vpc resource."
  value       = aviatrix_vpc.default
}

output "spoke_gateway" {
  description = "The created Aviatrix spoke gateway as an object with all of it's attributes."
  value       = var.ha_gw ? aviatrix_spoke_gateway.ha[0] : aviatrix_spoke_gateway.single[0]
}

output "vpn_gateway" {
  description = "A list of the created Aviatrix VPN gateways as an object with all of it's attributes."
  value       = aviatrix_gateway.vpn
}
