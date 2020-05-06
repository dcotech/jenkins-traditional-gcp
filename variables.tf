#---- global/VPC variables

variable "var_project" {
    default = "ps-dev-201405"
}

variable "env" {
    default = "dev"
}

variable "department" { 
    default = "dco-cloudbees"
}

#---- gce_instance/network variables

variable "uc1_private_subnet" {
    default = "10.26.1.0/24"
}

variable "uc1_public_subnet" {
    default = "10.26.2.0/24"
}

variable "region_name" {
    default = "us-east1"
}

variable "instance_size" {
    default = "n1-standard-1"
}