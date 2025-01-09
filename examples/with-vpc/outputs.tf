output "vpc_details" {
  description = "VPC 네트워크 세부 정보"
  value = {
    id                       = module.vpc.id
    name                     = module.vpc.name
    self_link                = module.vpc.self_link
    routing_mode             = module.vpc.routing_mode
    gateway_ipv4             = module.vpc.gateway_ipv4
    project                  = module.vpc.project
    auto_create_subnetworks  = module.vpc.auto_create_subnetworks
    mtu                      = module.vpc.mtu
    enable_ula_internal_ipv6 = module.vpc.enable_ula_internal_ipv6
  }
}


output "subnet_details" {
  description = "서브네트워크 세부 정보"
  value = {
    id                         = module.subnet.id
    name                       = module.subnet.name
    self_link                  = module.subnet.self_link
    gateway_address            = module.subnet.gateway_address
    region                     = module.subnet.region
    network                    = module.subnet.network
    ipv6_cidr_range            = module.subnet.ipv6_cidr_range
    private_ip_google_access   = module.subnet.private_ip_google_access
    private_ipv6_google_access = module.subnet.private_ipv6_google_access
  }
}