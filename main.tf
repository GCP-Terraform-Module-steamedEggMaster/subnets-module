resource "google_compute_subnetwork" "private" {
  name = var.subnet_name                                   # 서브네트워크 이름
  region = var.subnet_region                               # 서브네트워크의 지역 (예: asia-northeast3)
  network = var.network_id                                 # VPC 네트워크 ID와 연결
  private_ip_google_access = var.private_ip_google_access  # GCP 리소스가 서브네트워크의 프라이빗 IP에 접근 가능 여부
  ip_cidr_range = var.subnet_ip_cidr_range                 # IP CIDR 범위
  
  dynamic "secondary_ip_range" {                           # Kubernetes Pod의 secondary IP CIDR 범위
    for_each = var.secondary_ip_ranges
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
  
  enable_flow_logs = var.enable_flow_logs                  # 흐름 로그 활성화 여부

  log_config {                                             # 흐름 로그 구성
    aggregation_interval = var.log_aggregation_interval
    flow_sampling        = var.log_flow_sampling
    metadata             = var.log_metadata
  }
}