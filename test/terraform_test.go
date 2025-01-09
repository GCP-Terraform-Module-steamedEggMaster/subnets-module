package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformModule(t *testing.T) {
	// Terraform 설정
	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/with-vpc", // Terraform 코드 위치
	}

	// Terraform Init 및 Apply 실행
	defer terraform.Destroy(t, terraformOptions) // 테스트 종료 후 리소스 정리
	terraform.InitAndApply(t, terraformOptions)

	// stateFilePath := "../examples/with-vpc/terraform.tfstate"
	// stateFileContent, err := ioutil.ReadFile(filepath.Clean(stateFilePath))
	// if err != nil {
	// 	t.Fatalf("Failed to read Terraform state file: %v", err) // 오류 처리
	// } else {
	// 	log.Printf("Terraform State File Content:\n%s", string(stateFileContent)) // 상태 파일 내용 출력
	// }
	// // 5. state file을 확인하여 잘 넘어간 것만 확인하거나
	// //    with-vpc에서 outputs.tf를 정의하면 됨

	// // VPC 출력값 확인
	// networkID := terraform.Output(t, terraformOptions, "network_id")
	// assert.NotEmpty(t, networkID, "VPC Network ID should not be empty")

	// // Subnet 출력값 확인
	// subnetworkID := terraform.Output(t, terraformOptions, "subnetwork_id")
	// assert.NotEmpty(t, subnetworkID, "Subnet ID should not be empty")
	// // 이 값을 내가 출력하려고 하기때문에 에러가 발생했던 것.
	// // 1. Terraform 자식 모듈(내가 정의한 vpc, subnets) 간에는 outputs를 정의했으니
	// // 2. 두 모듈 간에는 값이 잘 넘어갔음.
	// // 3. 하지만, 내가 현재 루트 모듈에서 그 값을 노출시키려고 하니!
	// // 4. 루트 모듈에서 또한 output이 정의되어 있어야 가능해지는 것임!!
}
