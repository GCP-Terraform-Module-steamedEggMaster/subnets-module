resource "google_compute_subnetwork" "subnetwork" {
  # 필수 옵션
  name    = var.name    # 서브네트워크 이름
  network = var.network # 서브네트워크가 속한 VPC 네트워크

  # 선택적 옵션
  ## 기본 설정
  description             = var.description             # 서브네트워크 설명
  ip_cidr_range           = var.ip_cidr_range           # 서브네트워크의 IP CIDR 범위
  reserved_internal_range = var.reserved_internal_range # 예약된 내부 범위 ID
  purpose                 = var.purpose                 # 서브네트워크의 목적 (PRIVATE 등)
  role                    = var.role                    # 서브네트워크의 역할 (ACTIVE 또는 BACKUP)
  region                  = var.region                  # 서브네트워크가 생성될 GCP 리전

  ## IPv6 관련 설정
  stack_type           = var.stack_type           # 서브네트워크의 스택 유형 (IPV4_ONLY 등)
  ipv6_access_type     = var.ipv6_access_type     # 서브네트워크의 IPv6 접근 유형
  external_ipv6_prefix = var.external_ipv6_prefix # 외부 IPv6 주소 범위

  ## Google API 접근 설정
  private_ip_google_access   = var.private_ip_google_access   # Private Google Access 활성화 여부
  private_ipv6_google_access = var.private_ipv6_google_access # Private IPv6 Google Access 유형

  ## Secondary IP Range 설정
  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges
    content {
      range_name              = secondary_ip_range.value.range_name              # Secondary IP 범위 이름
      ip_cidr_range           = secondary_ip_range.value.ip_cidr_range           # Secondary IP CIDR 범위
      reserved_internal_range = secondary_ip_range.value.reserved_internal_range # 예약된 내부 범위 ID
    }
  }

  ## 로그 설정
  dynamic "log_config" {
    for_each = var.log_config != null ? [var.log_config] : []
    content {
      aggregation_interval = log_config.value.aggregation_interval # 로그 수집 간격
      flow_sampling        = log_config.value.flow_sampling        # 로그 샘플링 비율
      metadata             = log_config.value.metadata             # 로그에 포함할 메타데이터
      metadata_fields      = log_config.value.metadata_fields      # 포함할 메타데이터 필드
      filter_expr          = log_config.value.filter_expr          # 로그 필터 조건
    }
  }

  ## 기타 설정
  send_secondary_ip_range_if_empty = var.send_secondary_ip_range_if_empty # Secondary IP Range 제거 시 동작

  # Timeout 설정
  timeouts {
    create = var.timeout_create # 리소스 생성 제한 시간
    update = var.timeout_update # 리소스 업데이트 제한 시간
    delete = var.timeout_delete # 리소스 삭제 제한 시간
  }
}