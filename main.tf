#Aviatrix VPN Gateway
resource "aviatrix_gateway" "vpn" {
  count            = var.vpn_gw_count
  cloud_type       = 1
  account_name     = var.account
  gw_name          = "${var.name}-vpn-gw-${count.index + 1}"
  vpc_id           = var.vpc_id
  vpc_reg          = var.region
  gw_size          = var.instance_size
  subnet           = var.subnets[(count.index % 2)]
  vpn_access       = true
  vpn_cidr         = var.vpn_cidr[count.index]
  split_tunnel     = var.vpn_split_tunnel
  additional_cidrs = var.vpn_additional_cidrs
  search_domains   = var.vpn_search_domains
  name_servers     = var.vpn_name_servers
  max_vpn_conn     = var.vpn_max_vpn_conn
  enable_elb       = true #Required for User Accelerator
  elb_name         = "${var.name}-elb"
  saml_enabled     = var.vpn_saml_enabled
  enable_vpn_nat   = var.vpn_enable_vpn_nat
}

# Create an Aviatrix Vpn User Accelerator
resource "aviatrix_vpn_user_accelerator" "vpc_accelerator" {
  count    = var.vpn_user_accelerator ? 1 : 0
  elb_name = aviatrix_gateway.vpn[0].elb_name
}
