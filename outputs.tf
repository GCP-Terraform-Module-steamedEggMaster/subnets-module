output "id" {
  description = "서브네트워크의 고유 ID"
  value       = google_compute_subnetwork.subnetwork.id
}

output "name" {
  description = "서브네트워크의 이름"
  value       = google_compute_subnetwork.subnetwork.name
}

output "self_link" {
  description = "서브네트워크의 URI"
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

output "ipv6_cidr_range" {
  description = "서브네트워크의 내부 IPv6 범위"
  value       = google_compute_subnetwork.subnetwork.ipv6_cidr_range
}

output "network" {
  description = "서브네트워크가 속한 VPC 네트워크의 이름"
  value       = google_compute_subnetwork.subnetwork.network
}

output "purpose" {
  description = "서브네트워크의 목적 (예: PRIVATE, REGIONAL_MANAGED_PROXY 등)"
  value       = google_compute_subnetwork.subnetwork.purpose
}

output "stack_type" {
  description = "서브네트워크의 스택 유형 (예: IPV4_ONLY, IPV4_IPV6)"
  value       = google_compute_subnetwork.subnetwork.stack_type
}

output "private_ip_google_access" {
  description = "Google API 및 서비스에 대한 Private IP 접근 활성화 여부"
  value       = google_compute_subnetwork.subnetwork.private_ip_google_access
}

output "private_ipv6_google_access" {
  description = "서브네트워크의 Private IPv6 Google Access 유형"
  value       = google_compute_subnetwork.subnetwork.private_ipv6_google_access
}
