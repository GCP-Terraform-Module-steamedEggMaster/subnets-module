# subnets-module
GCP Terraform subnets module Repo

이 모듈은 GCP에서 서브네트워크(Subnetwork)를 생성하고 관리하기 위한 모듈입니다. <br>
사용자 정의 서브네트워크를 쉽게 구성할 수 있도록 설계되었습니다.

<br>

## 📑 **목차**
1. [모듈 특징](#모듈-특징)
2. [사용 방법](#사용-방법)
    1. [사전 준비](#1-사전-준비)
    2. [입력 변수](#2-입력-변수)
    3. [모듈 호출 예시](#3-모듈-호출-예시)
    4. [출력값 (Outputs)](#4-출력값-outputs)
    5. [지원 버전](#5-지원-버전)
    6. [모듈 개발 및 관리](#6-모듈-개발-및-관리)
3. [테스트](#terratest를-이용한-테스트)
4. [주요 버전 관리](#주요-버전-관리)
5. [기여](#기여-contributing)
6. [라이선스](#라이선스-license)

---

## 모듈 특징

- 사용자 정의 서브네트워크 생성.
- VPC 네트워크와 연결된 서브네트워크 설정 지원.
- Google Private Access 활성화 옵션 제공.
- Kubernetes Pod 및 Service를 위한 Secondary IP CIDR 범위 구성.
- 흐름 로그(Flow Log) 설정 가능
    - 로그 집계 간격(Aggregation Interval)
    - 로그 샘플링 비율(Sampling Rate)
    - 메타데이터 포함 여부 설정

---

## 사용 방법

### 1. 사전 준비

다음 사항을 확인하세요:
1. Google Cloud 프로젝트 준비.
2. 적절한 IAM 권한 필요: roles/compute.networkAdmin (서브네트워크 관리 권한 필수).
3. VPC 네트워크를 동시에 생성하거나, 이미 생성해놓아야 함.

<br>

### 2. 입력 변수

#### 필수 옵션

| 변수명    | 타입   | 필수 여부 | 기본값 | 설명                   |
|-----------|--------|-----------|--------|------------------------|
| `name`   | string | ✅        | 없음   | 서브네트워크 이름       |
| `network`| string | ✅        | 없음   | 서브네트워크가 속한 VPC |

<br>

#### 선택적 옵션
##### 기본 설정
| 변수명                  | 타입   | 필수 여부 | 기본값 | 설명                                |
|-------------------------|--------|-----------|--------|-------------------------------------|
| `description`          | string | ❌        | `null` | 서브네트워크 설명                   |
| `ip_cidr_range`        | string | ✅        | 없음   | 서브네트워크의 IP CIDR 범위         |
| `reserved_internal_range` | string | ❌      | `null` | 예약된 내부 범위 ID                |
| `purpose`              | string | ❌        | `PRIVATE` | 서브네트워크의 목적 (PRIVATE 등)   |
| `role`                 | string | ❌        | `null` | 서브네트워크의 역할 (ACTIVE/BACKUP) |
| `region`               | string | ✅        | 없음   | 서브네트워크가 생성될 GCP 리전      |

##### IPv6 관련 설정
| 변수명                  | 타입   | 필수 여부 | 기본값     | 설명                                  |
|-------------------------|--------|-----------|------------|---------------------------------------|
| `stack_type`           | string | ❌        | `IPV4_ONLY`| 서브네트워크 스택 유형 (IPV4_ONLY 등) |
| `ipv6_access_type`     | string | ❌        | `null`     | 서브네트워크의 IPv6 접근 유형         |
| `external_ipv6_prefix` | string | ❌        | `null`     | 서브네트워크의 외부 IPv6 주소 범위    |

##### Google API 접근 설정
| 변수명                    | 타입   | 필수 여부 | 기본값 | 설명                                  |
|---------------------------|--------|-----------|--------|---------------------------------------|
| `private_ip_google_access` | bool  | ❌        | `false`| Private Google Access 활성화 여부     |
| `private_ipv6_google_access` | string | ❌      | `null` | Private IPv6 Google Access 유형       |

##### Secondary IP Range 설정
| 변수명                   | 타입   | 필수 여부 | 기본값 | 설명                                |
|--------------------------|--------|-----------|--------|-------------------------------------|
| `secondary_ip_ranges`   | list   | ❌        | `[]`   | Secondary IP CIDR 범위 구성 목록     |

##### 로그 설정
| 변수명          | 타입   | 필수 여부 | 기본값 | 설명                           |
|-----------------|--------|-----------|--------|--------------------------------|
| `log_config`   | object | ❌        | `null` | VPC 플로우 로깅 구성           |

#### 기타 설정
| 변수명                          | 타입   | 필수 여부 | 기본값 | 설명                                    |
|---------------------------------|--------|-----------|--------|-----------------------------------------|
| `send_secondary_ip_range_if_empty` | bool | ❌        | `false`| Secondary IP Range 제거 시 동작          |

#### Timeout 설정
| 변수명            | 타입   | 필수 여부 | 기본값  | 설명                         |
|-------------------|--------|-----------|---------|------------------------------|
| `timeout_create` | string | ❌        | `"20m"`| 리소스 생성 제한 시간         |
| `timeout_update` | string | ❌        | `"20m"`| 리소스 업데이트 제한 시간     |
| `timeout_delete` | string | ❌        | `"20m"`| 리소스 삭제 제한 시간         |

<br>

### 3. 모듈 호출 예시

```hcl
module "subnetwork" {
  source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/subnets-module.git?ref=v1.0.0"

  name                    = "custom-subnet"
  region                  = "asia-northeast3"
  network                 = "projects/my-project/global/networks/my-vpc"
  ip_cidr_range           = "10.0.0.0/16"
  private_ip_google_access = true

  secondary_ip_ranges = [
    {
      range_name    = "secondary-1"
      ip_cidr_range = "10.1.0.0/24"
    },
    {
      range_name    = "secondary-2"
      ip_cidr_range = "10.2.0.0/24"
    }
  ]

  log_config = {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.7
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
```

<br>

### 4. 출력값 (Outputs)

| 출력명                     | 설명                                          |
|----------------------------|-----------------------------------------------|
| `id`                       | 서브네트워크의 고유 ID                        |
| `name`                     | 서브네트워크의 이름                           |
| `self_link`                | 서브네트워크의 고유 URI                      |
| `gateway_address`          | 서브네트워크의 기본 게이트웨이 주소           |
| `region`                   | 서브네트워크가 생성된 리전                    |
| `ip_cidr_range`            | 서브네트워크의 기본 IP CIDR 범위             |
| `ipv6_cidr_range`          | 서브네트워크의 내부 IPv6 범위                 |
| `network`                  | 서브네트워크가 속한 VPC 네트워크의 ID         |
| `private_ip_google_access` | Google API 및 서비스에 대한 Private IP 접근 활성화 여부 |
| `private_ipv6_google_access` | 서브네트워크의 Private IPv6 Google Access 유형 |
| `stack_type`               | 서브네트워크의 스택 유형 (예: IPV4_ONLY 또는 IPV4_IPV6) |
| `ipv6_access_type`         | 서브네트워크의 IPv6 접근 유형 (예: INTERNAL 또는 EXTERNAL) |
| `secondary_ip_ranges`      | 서브네트워크에 설정된 Secondary IP 범위 목록  |
| `log_config`               | 서브네트워크의 VPC 플로우 로깅 설정           |
| `creation_timestamp`       | 서브네트워크가 생성된 시간 (RFC3339 형식)     |



<br>

### 5. 지원 버전

#### a.  Terraform 버전
| 버전 범위 | 설명                              |
|-----------|-----------------------------------|
| `1.10.3`   | 최신 버전, 지원 및 테스트 완료                  |

#### b. Google Provider 버전
| 버전 범위 | 설명                              |
|-----------|-----------------------------------|
| `~> 6.0`  | 최소 지원 버전                   |

<br>

### 6. 모듈 개발 및 관리

- **저장소 구조**:
  ```
  subnets-module/
    ├── .github/workflows/  # github actions 자동화 테스트
    ├── examples/           # 테스트를 위한 루트 모듈 모음 디렉터리
    ├── test/               # 테스트 구성 디렉터리
    ├── main.tf             # 모듈의 핵심 구현
    ├── variables.tf        # 입력 변수 정의
    ├── outputs.tf          # 출력 정의
  ├── versions.tf         # 버전 정의    ├── README.md           # 문서화 파일
  ```

<br>

---

### Terratest를 이용한 테스트
이 모듈을 테스트하려면 제공된 Go 기반 테스트 프레임워크를 사용하세요. 아래를 확인하세요:

1. Terraform 및 Go 설치.
2. 필요한 환경 변수 설정.
3. 테스트 실행:
```bash
go test -v ./test
```

<br>

## 주요 버전 관리
이 모듈은 [Semantic Versioning](https://semver.org/)을 따릅니다.  
안정된 버전을 사용하려면 `?ref=<version>`을 활용하세요:

```hcl
source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/subnets-module.git?ref=v1.0.0"
```

### Module ref 버전
| Major | Minor | Patch |
|-----------|-----------|----------|
| `1.0.0`   |    |   |

<br>

## 기여 (Contributing)
기여를 환영합니다! 버그 제보 및 기능 요청은 GitHub Issues를 통해 제출해주세요.

<br>

## 라이선스 (License)
[MIT License](LICENSE)