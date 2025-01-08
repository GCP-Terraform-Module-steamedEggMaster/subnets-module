package helpers

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// VPC를 생성하고 VPC ID와 정리 함수를 반환합니다.
func CreateVPC(t *testing.T, projectID string) (string, func()) {
	vpcOptions := &terraform.Options{
		// GitHub에 있는 VPC 모듈 경로 설정
		TerraformDir: "./vpc",

		// VPC 모듈 입력 변수 설정
		Vars: map[string]interface{}{
			"project_id":       projectID,
			"vpc_network_name": "test-vpc",
			"routing_mode":     "REGIONAL",
		},

		// GitHub에서 VPC 모듈을 가져오기 위한 경로
		BackendConfig: map[string]interface{}{
			"source": "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/vpc-module.git?ref=v1.0.0",
		},
	}

	terraform.InitAndApply(t, vpcOptions)              // Terraform Init 및 Apply 실행
	networkID := terraform.Output(t, vpcOptions, "network_id") // VPC 출력값 가져오기

	// 정리 함수 반환
	return networkID, func() {
		terraform.Destroy(t, vpcOptions)
	}
}
