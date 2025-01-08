package test

import (
	"os"
	"testing"
	
	"github.com/test/subnets-module/helpers" // 헬퍼 함수 파일 경로
)

func TestTerraformModule(t *testing.T) {
	// 환경 변수에서 GCP 프로젝트 ID를 가져옵니다.
	projectID := os.Getenv("GCP_PROJECT_ID")

	// VPC 생성 및 정리 함수 설정
	networkID, vpcCleanup := helpers.CreateVPC(t, projectID)
	defer vpcCleanup()

	// 서브네트워크 생성 및 정리 함수 설정
	expectedSubnetID, subnetworkOptions, subnetworkCleanup := helpers.CreateSubnetwork(t, networkID, projectID)
	defer subnetworkCleanup()

	// 서브네트워크 출력값 검증
	helpers.VerifySubnetworkOutputs(t, subnetworkOptions, expectedSubnetID)
}
