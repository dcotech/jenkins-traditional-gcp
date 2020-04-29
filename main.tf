provider "google" {
    project     = "${var.var_project}"
    region      = "us-east1"
}

module "vpc" {
  source                 = "./modules/global"
  env                    = "${var.env}"
  department             = "${var.department}"
  uc1_public_subnet      = "${var.uc1_public_subnet}"
  uc1_private_subnet     = "${var.uc1_private_subnet}"
  region_name = "${var.region_name}"
}

module "gce_instance" {
  source = "./modules/gce_instance"
  env    = "${var.env}"
  department = "${var.department}"
  #network_self_link = "${module.vpc.out_vpc_self_link}"
  #subnetwork1 = "${module.gce_instance.uc1_out_public_subnet_name}"
  uc1_public_subnet = "${var.uc1_public_subnet}"
  uc1_private_subnet = "${var.uc1_private_subnet}"
  region_name = "${var.region_name}"
}