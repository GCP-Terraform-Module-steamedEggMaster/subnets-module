package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformModule(t *testing.T) {
	// Terraform 설정
	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/with-vpc", // Terraform 코드 위치

		Vars: map[string]interface{}{
			"vpc_network_name":      "test-vpc",
			"subnet_name":           "test-subnet",
			"subnet_region":         "asia-northeast3",
			"subnet_ip_cidr_range":  "10.0.0.0/16",
		},
	}

	// Terraform Init 및 Apply 실행
	defer terraform.Destroy(t, terraformOptions) // 테스트 종료 후 리소스 정리
	terraform.InitAndApply(t, terraformOptions)

	// VPC 출력값 확인
	networkID := terraform.Output(t, terraformOptions, "network_id")
	t.Logf("Debug: VPC Network ID = %s", networkID) // 상태 출력값 디버깅
	assert.NotEmpty(t, networkID, "VPC Network ID should not be empty")

	// Subnet 출력값 확인
	subnetworkID := terraform.Output(t, terraformOptions, "subnetwork_id")
	t.Logf("Debug: Subnet ID = %s", subnetworkID) // 상태 출력값 디버깅
	assert.NotEmpty(t, subnetworkID, "Subnet ID should not be empty")
}
