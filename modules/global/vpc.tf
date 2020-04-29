######################################################################
# Configures VPC, Networking, and Firewall
######################################################################

resource "google_compute_network" "vpc" {
  name                    = "${var.department}-${var.env}-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_firewall" "allow-internal" {
    name    = "${var.department}-fw-allow-internal"
    network = "${google_compute_network.vpc.name}"

    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports    = ["0-65535"]
    }

    allow {
        protocol = "udp"
        ports    = ["0-65535"]
    }

    source_ranges = [
        "${var.uc1_private_subnet}",
        "${var.uc1_public_subnet}"
    ]
}

resource "google_compute_firewall" "allow-external" {
    name    = "${var.department}-fw-allow-http"
    network = "${google_compute_network.vpc.name}"

    allow {
        protocol = "tcp"
        ports    = ["80"]
    }

    target_tags = ["http"]
}

resource "google_compute_firewall" "allow-ssh" {
    name    = "${var.department}-fw-allow-ssh"
    network = "${google_compute_network.vpc.name}"
    allow {
        protocol = "tcp"
        ports = ["22"]
    }

    target_tags = ["ssh"]  
}

resource "google_compute_subnetwork" "public_subnet" {
    name          = "${var.department}-${var.env}-${var.region_name}-pub-net"
    ip_cidr_range = "${var.uc1_public_subnet}"
    network       = "${google_compute_network.vpc.self_link}"
    region        = "${var.region_name}"
}

resource "google_compute_subnetwork" "private_subnet" {
    name = "${var.department}-${var.env}-${var.region_name}-private-net"
    ip_cidr_range = "${var.uc1_private_subnet}"
    network = "${google_compute_network.vpc.self_link}"
    region = "${var.region_name}"
}