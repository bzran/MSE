provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "this" {
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "this" {
  availability_zone = "cn-beijing-b"
  cidr_block = "172.16.0.0/21"
  vpc_id = alicloud_vpc.this.id
}

resource "alicloud_mse_cluster" "example" {
  cluster_specification = "MSE_SC_1_2_200_c"
  cluster_type = "Eureka"
  cluster_version = "EUREKA_1_9_3"
  instance_count = 1
  net_type = "privatenet"
  vswitch_id = alicloud_vswitch.this.id
  pub_network_flow = "1"
  acl_entry_list= ["127.0.0.1/32"]
  cluster_alias_name= "tf-testAccMseCluster"
}