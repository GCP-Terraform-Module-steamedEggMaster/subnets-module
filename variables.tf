# 필수 변수
variable "name" {
  description = "서브네트워크 이름 (RFC1035 규칙 준수)"
  type        = string
}

variable "network" {
  description = "서브네트워크가 속한 VPC 네트워크"
  type        = string
}

# 선택적 변수

## 기본 설정
variable "description" {
  description = "서브네트워크 설명 (선택 사항)"
  type        = string
  default     = null
}

variable "ip_cidr_range" {
  description = "서브네트워크의 CIDR 범위 (예: 192.168.0.0/16)"
  type        = string
  default     = null
}

variable "reserved_internal_range" {
  description = "예약된 내부 범위의 ID"
  type        = string
  default     = null
}

variable "purpose" {
  description = "서브네트워크의 목적 (PRIVATE, REGIONAL_MANAGED_PROXY 등)"
  type        = string
  default     = "PRIVATE"
}

variable "role" {
  description = "서브네트워크의 역할 (ACTIVE 또는 BACKUP)"
  type        = string
  default     = null
}

variable "region" {
  description = "서브네트워크가 생성될 GCP 리전"
  type        = string
}

## IPv6 관련 설정
variable "stack_type" {
  description = "서브네트워크 스택 유형 (IPV4_ONLY 또는 IPV4_IPV6)"
  type        = string
  default     = "IPV4_ONLY"
}

variable "ipv6_access_type" {
  description = "서브네트워크의 IPv6 접근 유형 (EXTERNAL 또는 INTERNAL)"
  type        = string
  default     = null
}

variable "external_ipv6_prefix" {
  description = "서브네트워크의 외부 IPv6 범위"
  type        = string
  default     = null
}

## Google API 접근 설정
variable "private_ip_google_access" {
  description = "Google API 및 서비스에 대한 Private IP 접근 활성화 여부"
  type        = bool
  default     = false
}

variable "private_ipv6_google_access" {
  description = "VM의 Private IPv6 Google Access 유형"
  type        = string
  default     = null
}

## Secondary IP Range 설정
variable "secondary_ip_ranges" {
  description = "Secondary IP Range 구성 목록"
  type = list(object({
    range_name              = string
    ip_cidr_range           = string
    reserved_internal_range = string
  }))
  default = []
}

## 로그 설정
variable "log_config" {
  description = "VPC 플로우 로깅 구성"
  type = object({
    aggregation_interval = string
    flow_sampling        = number
    metadata             = string
    metadata_fields      = list(string)
    filter_expr          = string
  })
  default = null
}

## 기타 설정
variable "send_secondary_ip_range_if_empty" {
  description = "Secondary IP Range를 비워두었을 때의 동작"
  type        = bool
  default     = false
}

# Timeout 변수
variable "timeout_create" {
  description = "리소스 생성 제한 시간"
  type        = string
  default     = "20m"
}

variable "timeout_update" {
  description = "리소스 업데이트 제한 시간"
  type        = string
  default     = "20m"
}

variable "timeout_delete" {
  description = "리소스 삭제 제한 시간"
  type        = string
  default     = "20m"
}
