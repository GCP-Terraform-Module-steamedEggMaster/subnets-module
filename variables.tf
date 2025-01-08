variable "subnet_name" {
  description = "The name of the subnetwork"
  type        = string
}

variable "subnet_region" {
  description = "The region where the subnetwork will be created"
  type        = string
}

variable "network_id" {
  description = "The ID of the VPC network where this subnetwork will be created"
  type        = string
}

variable "private_ip_google_access" {
  description = "Whether to enable Google Private Access for the subnetwork"
  type        = bool
  default     = false
}

variable "subnet_ip_cidr_range" {
  description = "The primary IP CIDR range of the subnetwork"
  type        = string
}

variable "secondary_ip_ranges" {
  description = "A list of secondary IP ranges for the subnetwork"
  type = list(object({
    range_name    = string
    ip_cidr_range = string
  }))
  default = []
}

variable "enable_flow_logs" {
  description = "Enable flow logs for the subnetwork"
  type        = bool
  default     = false
}

variable "log_aggregation_interval" {
  description = "The aggregation interval for the flow logs"
  type        = string
  default     = "INTERVAL_5_SEC"
}

variable "log_flow_sampling" {
  description = "The sampling rate for the flow logs"
  type        = number
  default     = 0.5
}

variable "log_metadata" {
  description = "The metadata fields to include in the flow logs"
  type        = string
  default     = "INCLUDE_ALL_METADATA"
}