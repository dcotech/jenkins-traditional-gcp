######################################################################
# Outputs under the "global" module
######################################################################

output "uc1_out_public_subnet_name" {
    value = "${google_compute_subnetwork.public_subnet.name}"
} #outputs are needed to communicate across modules; modules cannot reach into other modules resources directly
