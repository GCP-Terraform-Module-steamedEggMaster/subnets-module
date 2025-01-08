package helpers

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// 서브네트워크 출력값을 검증합니다.
func VerifySubnetworkOutputs(t *testing.T, options *terraform.Options, expectedSubnetID string) {
	subnetworkId := terraform.Output(t, options, "subnetwork_id")
	subnetworkName := terraform.Output(t, options, "subnetwork_name")
	subnetworkSelfLink := terraform.Output(t, options, "subnetwork_self_link")
	subnetworkRegion := terraform.Output(t, options, "subnetwork_region")

	assert.Equal(t, expectedSubnetID, subnetworkId, "Subnetwork ID does nnt equal the subnet name")
	assert.Equal(t, "test-subnet", subnetworkName, "Subnetwork name does not match")
	assert.Contains(t, subnetworkSelfLink, "test-subnet", "Subnetwork self-link does not contain the subnet name")
	assert.Equal(t, "asia-northeast3", subnetworkRegion, "Subnetwork region does not match")
}