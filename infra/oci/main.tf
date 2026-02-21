provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

############################################
# VCN
############################################
resource "oci_core_virtual_network" "lab_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_id
  display_name   = "lab-vcn"
}

############################################
# Internet Gateway (REQUIRED FOR SSH)
############################################
resource "oci_core_internet_gateway" "lab_igw" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.lab_vcn.id
  display_name   = "lab-internet-gateway"
  enabled        = true
}

############################################
# Route Table → send traffic to internet
############################################
resource "oci_core_route_table" "lab_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.lab_vcn.id
  display_name   = "lab-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.lab_igw.id
  }
}

############################################
# Security List
############################################
resource "oci_core_security_list" "lab_sec_list" {
  compartment_id = var.compartment_id
  display_name   = "lab-sec-list"
  vcn_id         = oci_core_virtual_network.lab_vcn.id

  # SSH from home — always append /32 here
  ingress_security_rules {
    protocol = "6"
    source   = "${var.my_ip}/32"  # single IP CIDR
    tcp_options {
      min = 22
      max = 22
    }
  }

  # Internal VM traffic (all VMs in subnet)
  ingress_security_rules {
    protocol = "6"
    source   = "10.0.1.0/24"      # allow the entire subnet
    tcp_options {
      min = 9200
      max = 9200
    }
  }

  # outbound internet
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

############################################
# Subnet (with routing + security attached)
############################################
resource "oci_core_subnet" "lab_subnet" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.lab_vcn.id
  cidr_block     = "10.0.1.0/24"
  display_name   = "lab-subnet"

  prohibit_public_ip_on_vnic = false

  route_table_id    = oci_core_route_table.lab_route_table.id
  security_list_ids = [oci_core_security_list.lab_sec_list.id]
}

############################################
# VM1
############################################
resource "oci_core_instance" "vm1" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  shape               = var.vm_shape
  display_name        = "vm1"

  create_vnic_details {
    subnet_id        = oci_core_subnet.lab_subnet.id
    assign_public_ip = true
    display_name     = "vm1-vnic"
  }

  source_details {
    source_type = "image"
    source_id   = var.ubuntu_image_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}

############################################
# VM2
############################################
resource "oci_core_instance" "vm2" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  shape               = var.vm_shape
  display_name        = "vm2"

  create_vnic_details {
    subnet_id        = oci_core_subnet.lab_subnet.id
    assign_public_ip = true
    display_name     = "vm2-vnic"
  }

  source_details {
    source_type = "image"
    source_id   = var.ubuntu_image_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}

############################################
# Outputs
############################################
output "vm1_private_ip" {
  value = oci_core_instance.vm1.private_ip
}

output "vm2_private_ip" {
  value = oci_core_instance.vm2.private_ip
}

output "vm1_public_ip" {
  value = oci_core_instance.vm1.public_ip
}

output "vm2_public_ip" {
  value = oci_core_instance.vm2.public_ip
}
