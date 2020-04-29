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
}