# subnets-module
GCP Terraform subnets module Repo

이 모듈은 GCP에서 서브네트워크(Subnetwork)를 생성하고 관리하기 위한 모듈입니다. <br>
사용자 정의 서브네트워크를 쉽게 구성할 수 있도록 설계되었습니다.

<br>

---

## 📋 **모듈 특징**

- 사용자 정의 서브네트워크 생성.
- VPC 네트워크와 연결된 서브네트워크 설정 지원.
- Google Private Access 활성화 옵션 제공.
- Kubernetes Pod 및 Service를 위한 Secondary IP CIDR 범위 구성.
- 흐름 로그(Flow Log) 설정 가능
    - 로그 집계 간격(Aggregation Interval)
    - 로그 샘플링 비율(Sampling Rate)
    - 메타데이터 포함 여부 설정

---

## 🔧 사용 방법

### 1. 사전 준비

다음 사항을 확인하세요:
1. Google Cloud 프로젝트 준비.
2. 적절한 IAM 권한 필요: roles/compute.networkAdmin (서브네트워크 관리 권한 필수).
3. VPC 네트워크를 동시에 생성하거나, 이미 생성해놓아야 함.

<br>

### 2. 입력 변수

| 변수명                        | 타입   | 필수 여부 | 기본값                   | 설명                                   |
|-------------------------------|--------|-----------|--------------------------|----------------------------------------|
| `subnet_name`                 | string | ✅        | 없음                     | 서브네트워크의 이름                     |
| `subnet_region`               | string | ✅        | 없음                     | 서브네트워크가 생성될 지역 (예: `asia-northeast3`) |
| `network_id`                  | string | ✅        | 없음                     | VPC 네트워크 ID                        |
| `private_ip_google_access`    | bool   | ❌        | `false`                  | Google Private Access 활성화 여부      |
| `subnet_ip_cidr_range`        | string | ✅        | 없음                     | 서브네트워크의 기본 IP CIDR 범위       |
| `secondary_ip_ranges`         | list   | ❌        | `[]`                     | Secondary IP CIDR 범위 구성 리스트      |
| `log_aggregation_interval`    | string | ❌        | `INTERVAL_5_SEC`         | 흐름 로그의 집계 간격 설정             |
| `log_flow_sampling`           | number | ❌        | `0.5`                    | 흐름 로그의 샘플링 비율                |
| `log_metadata`                | string | ❌        | `INCLUDE_ALL_METADATA`   | 흐름 로그에 포함할 메타데이터 설정      |

<br>

### 3. 모듈 호출 예시

```hcl
module "subnetwork" {
  source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/subnets-module.git?ref=v1.0.0"

  subnet_name              = "custom-subnet"
  subnet_region            = "asia-northeast3"
  network_id               = "projects/my-project-id/global/networks/my-vpc"
  private_ip_google_access = true
  subnet_ip_cidr_range     = "10.0.0.0/16"

  secondary_ip_ranges = [
    {
      range_name    = "k8s-pod-range",
      ip_cidr_range = "10.1.0.0/16"
    },
    {
      range_name    = "k8s-service-range",
      ip_cidr_range = "10.2.0.0/16"
    }
  ]

  log_aggregation_interval = "INTERVAL_10_MIN"
  log_flow_sampling        = 0.7
  log_metadata             = "INCLUDE_ALL_METADATA"
}
```

<br>

### 4. 출력값 (Outputs)

| 출력명               | 설명                                      |
|----------------------|----------------------------------------|
| `subnetwork_id`         | 생성된 서브네트워크의 ID                  |
| `subnetwork_name`       | 생성된 서브네트워크의 이름                 |
| `subnetwork_self_link`  | 생성된 서브네트워크의 self-link           |
| `subnetwork_region`     | 생성된 서브네트워크의 지역                 |
| `subnetwork_network`    | 생성된 서브네트워크가 연결된 VPC 네트워크 ID  |

<br>

### 5. 지원 버전

#### a.  Terraform 버전
| 버전 범위 | 설명                              |
|-----------|-----------------------------------|
| `1.10.3`   | 최신 버전, 지원 및 테스트 완료                  |

#### b. Google Provider 버전
| 버전 범위 | 설명                              |
|-----------|-----------------------------------|
| `~> 4.0`  | 최소 지원 버전                   |

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
    ├── README.md           # 문서화 파일
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