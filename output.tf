output "vpn_gateway" {
  description = "A list of the created Aviatrix VPN gateways as an object with all of it's attributes."
  value       = aviatrix_gateway.vpn
}

output "elb_dns_name" {
  description = "DNS name of the ELB (if deployed)."
  value       = aviatrix_gateway.vpn[0].elb_dns_name
}
