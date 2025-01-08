package helpers

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// 서브네트워크를 생성하고 정리 함수를 반환합니다.
func CreateSubnetwork(t *testing.T, networkID string, projectID string) (string, func()) {
	subnetworkOptions := &terraform.Options{
		TerraformDir: "../../", // 서브네트워크 모듈 경로

		subnetName := "test-subnet"
		subnetRegion := "asia-northeast3"

		// 서브네트워크 모듈 입력 변수 설정
		Vars: map[string]interface{}{
			"vpc_network_id":        networkID,
			"subnet_name":           subnetName,
			"subnet_ip_cidr_range":  "10.0.0.0/16",
			"subnet_region":         subnetRegion,
			"private_ip_google_access": true,
			"secondary_ip_ranges": []map[string]interface{}{
				{
					"range_name":    "k8s-pod-range",
					"ip_cidr_range": "10.1.0.0/16",
				},
				{
					"range_name":    "k8s-service-range",
					"ip_cidr_range": "10.2.0.0/16",
				},
			},
		},
	}

	// subnet ID 설정
	expectedSubnetID := fmt.Sprintf("projects/%s/regions/%s/subnetworks/%s", projectID, subnetRegion, subnetName)

	terraform.InitAndApply(t, subnetworkOptions) // Terraform Init 및 Apply 실행
	
	return expectedSubnetID, func() {			 // 정리 함수 반환
		terraform.Destroy(t, subnetworkOptions)
	}
}
