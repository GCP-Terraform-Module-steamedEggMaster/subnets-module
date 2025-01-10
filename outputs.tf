output "id" {
  description = "서브네트워크의 고유 ID"
  value       = google_compute_subnetwork.subnetwork.id
}

output "name" {
  description = "서브네트워크의 이름"
  value       = google_compute_subnetwork.subnetwork.name
}

output "self_link" {
  description = "서브네트워크의 고유 URI"
  value       = google_compute_subnetwork.subnetwork.self_link
}

output "gateway_address" {
  description = "서브네트워크의 기본 게이트웨이 주소"
  value       = google_compute_subnetwork.subnetwork.gateway_address
}

output "region" {
  description = "서브네트워크가 생성된 리전"
  value       = google_compute_subnetwork.subnetwork.region
}

output "network" {
  description = "서브네트워크가 속한 VPC 네트워크의 ID"
  value       = google_compute_subnetwork.subnetwork.network
}

output "ip_cidr_range" {
  description = "서브네트워크의 기본 IP CIDR 범위"
  value       = google_compute_subnetwork.subnetwork.ip_cidr_range
}

output "ipv6_cidr_range" {
  description = "서브네트워크의 내부 IPv6 CIDR 범위 (활성화된 경우)"
  value       = google_compute_subnetwork.subnetwork.ipv6_cidr_range
}

output "private_ip_google_access" {
  description = "서브네트워크에서 Private Google Access 활성화 여부"
  value       = google_compute_subnetwork.subnetwork.private_ip_google_access
}

output "private_ipv6_google_access" {
  description = "서브네트워크의 Private IPv6 Google Access 유형"
  value       = google_compute_subnetwork.subnetwork.private_ipv6_google_access
}

output "stack_type" {
  description = "서브네트워크의 스택 유형 (IPV4_ONLY 또는 IPV4_IPV6)"
  value       = google_compute_subnetwork.subnetwork.stack_type
}

output "ipv6_access_type" {
  description = "서브네트워크의 IPv6 접근 유형 (EXTERNAL 또는 INTERNAL)"
  value       = google_compute_subnetwork.subnetwork.ipv6_access_type
}

output "secondary_ip_ranges" {
  description = "서브네트워크에 설정된 Secondary IP 범위 목록"
  value = [
    for range in google_compute_subnetwork.subnetwork.secondary_ip_range : {
      range_name    = range.range_name
      ip_cidr_range = range.ip_cidr_range
    }
  ]
}

output "log_config" {
  description = "서브네트워크의 VPC 플로우 로깅 설정"
  value = {
    aggregation_interval = try(google_compute_subnetwork.subnetwork.log_config[0].aggregation_interval, null)
    flow_sampling        = try(google_compute_subnetwork.subnetwork.log_config[0].flow_sampling, null)
    metadata             = try(google_compute_subnetwork.subnetwork.log_config[0].metadata, null)
    metadata_fields      = try(google_compute_subnetwork.subnetwork.log_config[0].metadata_fields, [])
    filter_expr          = try(google_compute_subnetwork.subnetwork.log_config[0].filter_expr, null)
  }
}

output "creation_timestamp" {
  description = "서브네트워크가 생성된 시간 (RFC3339 형식)"
  value       = google_compute_subnetwork.subnetwork.creation_timestamp
}