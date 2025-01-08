output "network_id" {
  value = module.vpc.network_id
  description = "The network ID from the VPC module"
}

output "subnetwork_id" {
  value = module.subnets.subnetwork_id
  description = "The network ID from the VPC module"
}