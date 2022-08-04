# terraform-aviatrix-aws-uservpn

### Description
This module deploys one or more Aviatrix UserVPN gateways behind an elastic loadbalancer.

### Usage Example
```
module "spoke_aws_1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.2.4"

  cloud          = "AWS"
  name           = "App1"
  cidr           = "10.1.0.0/20"
  region         = "eu-west-1"
  account        = "AWS"
  transit_gw     = "avx-eu-west-1-transit"
  network_domain = "blue"
}

module "vpn_1" {
  source  = "terraform-aviatrix-modules/aws-uservpn/aviatrix"
  version = "2.0.0"

  name    = "vpn1"
  region  = "eu-west-1"
  account = "AWS"
  vpc_id  = module.spoke_aws_1.vpc.vpc_id
  subnets = [
    module.spoke_aws_1.vpc.public_subnets[0].cidr,
    module.spoke_aws_1.vpc.public_subnets[1].cidr,
  ]
}
```

### Variables
The following variables are required:

key | value
:--- | :---
vpc_id | VPC ID of the VPC to deploy in.
name | Name for the VPN gateways
region | AWS region to deploy the transit VPC in
account | The AWS accountname on the Aviatrix controller, under which the controller will deploy the VPN gateway(s)

The following variables are optional:

key | default | value 
:---|:---|:---
instance_size | "t3.medium" | Size of the VPN gateway instances
vpn_gw_count | 2 | The amount of VPN Gateways to be deployed.
vpn_cidr | ["10.255.254.0/24", "10.255.255.0/24"] | List of subnets to be used by the VPN gateways for VPN Clients. Needs to contain enough entries for number of vpn_gw_count
vpn_split_tunnel | true | Allows default route to internet directly. Change to false if all traffic should be tunneled.
vpn_additional_cidrs | "10.0.0.0/8,192.168.0.0/16,172.16.0.0/12" | CIDR's to be routed through VPN when using split tunnelling
vpn_search_domains | | List of DNS Domains to search
vpn_name_servers | | List of DNS Servers to use
vpn_max_vpn_conn | 100 | Limit of concurrent users per VPN gateway
vpn_user_accelerator | true | Enable AWS Global Accelerator to optimize traffic quality
vpn_saml_enabled | false | Enable SAML authentication
vpn_enable_vpn_nat | true | Enable source NAT on VPN Gateways

### Outputs
This module will return the following outputs:

key | description
:---|:---
elb_dns_name | DNS name of the ELB (if deployed).
vpn_gateway | A list of the created Aviatrix VPN gateways as an object with all of it's attributes.
