module "vpc" {
  source  = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/vpc-module.git?ref=v1.0.0"

  vpc_network_name = var.vpc_network_name
}

module "subnets" {
  source = "../../" # subnets 모듈의 소스 경로

  subnet_name      = var.subnet_name
  subnet_region    = var.subnet_region
  network_id   = module.vpc.network_id # vpc 모듈의 출력값 사용
  subnet_ip_cidr_range = var.subnet_ip_cidr_range
}