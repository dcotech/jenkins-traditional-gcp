resource "google_compute_instance" "default" {
  name          = "${format("%s","${var.department}-${var.env}-${var.region_name}-instance1")}"
  machine_type  = "${var.instance_size}"
  #zone         =   "${element(var.var_zones, count.index)}"
  zone          =   "${format("%s","${var.region_name}-b")}"
  tags          = ["ssh","http"]
  boot_disk {
    initialize_params {
      image     =  "centos-7-v20180129"     
    }
  }
  
labels = {
      webserver =  "true"     
    }
metadata = {
        startup-script = <<SCRIPT
        apt-get -y update
        apt-get -y install nginx
        export HOSTNAME=$(hostname | tr -d '\n')
        export PRIVATE_IP=$(curl -sf -H 'Metadata-Flavor:Google' http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip | tr -d '\n')
        echo "Welcome to $HOSTNAME - $PRIVATE_IP" > /usr/share/nginx/www/index.html
        service nginx start
        SCRIPT
    }

network_interface {
    subnetwork = "${var.subnetwork}"
      // Ephemeral IP
    }
}
