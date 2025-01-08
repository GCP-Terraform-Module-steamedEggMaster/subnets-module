# variables.tf

variable "vpc_network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_region" {
  description = "The region of the subnet"
  type        = string
}

variable "subnet_ip_cidr_range" {
  description = "The CIDR range of the subnet"
  type        = string
}