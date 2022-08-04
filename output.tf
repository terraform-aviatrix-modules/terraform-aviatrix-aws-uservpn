output "vpn_gateway" {
  description = "A list of the created Aviatrix VPN gateways as an object with all of it's attributes."
  value       = aviatrix_gateway.vpn
}

output "elb_name" {
  description = "Name of the ELB (if deployed)."
  value       = aviatrix_gateway.vpn[0].elb_name
}
