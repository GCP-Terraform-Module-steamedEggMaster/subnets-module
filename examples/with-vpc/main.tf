module "vpc" {
  source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/vpc-module.git?ref=v1.0.0"

  vpc_network_name = var.vpc_network_name
}

module "subnet" {
  source = "../../" # subnets 모듈의 소스 경로

  # 필수 변수
  name    = "test-subnetwork"
  network = module.vpc.id

  # 선택적 변수 - 기본 설정
  description             = "Example Subnetwork for Demo"
  ip_cidr_range           = "10.0.0.0/24"
  reserved_internal_range = null
  purpose                 = "PRIVATE"
  role                    = null
  region                  = "asia-northeast3"

  # 선택적 변수 - IPv6 관련 설정
  stack_type           = "IPV4_ONLY"
  ipv6_access_type     = null
  external_ipv6_prefix = null

  # 선택적 변수 - Google API 접근 설정
  private_ip_google_access   = true
  private_ipv6_google_access = null

  # 선택적 변수 - Secondary IP Range 설정
  secondary_ip_ranges = [
    {
      range_name              = "secondary-range-1"
      ip_cidr_range           = "10.0.1.0/24"
      reserved_internal_range = null
    },
    {
      range_name              = "secondary-range-2"
      ip_cidr_range           = "10.0.2.0/24"
      reserved_internal_range = null
    }
  ]

  # 선택적 변수 - 로그 설정
  log_config = {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    metadata_fields      = []
    filter_expr          = "true"
  }

  # 선택적 변수 - 기타
  send_secondary_ip_range_if_empty = false
}