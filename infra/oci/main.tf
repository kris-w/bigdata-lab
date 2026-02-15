provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

# VCN
resource "oci_core_virtual_network" "lab_vcn" {
  cidr_block = "10.0.0.0/16"
  compartment_id = var.compartment_id
  display_name   = "lab-vcn"
}

# Subnet
resource "oci_core_subnet" "lab_subnet" {
  compartment_id      = var.compartment_id
  virtual_network_id  = oci_core_virtual_network.lab_vcn.id
  cidr_block          = "10.0.1.0/24"
  display_name        = "lab-subnet"
  prohibit_public_ip_on_vnic = false
}

# Security List for basic rules
resource "oci_core_security_list" "lab_sec_list" {
  compartment_id = var.compartment_id
  display_name   = "lab-sec-list"
  vcn_id         = oci_core_virtual_network.lab_vcn.id

  ingress_security_rules {
    protocol = "6"
    source   = var.my_ip
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.vm1_ip
    tcp_options {
      min = 9200
      max = 9200
    }
  }

  egress_security_rules {
    protocol = "all"
    destination = "0.0.0.0/0"
  }
}

# VM1
resource "oci_core_instance" "vm1" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  shape               = var.vm_shape
  display_name        = "vm1"

  create_vnic_details {
    subnet_id = oci_core_subnet.lab_subnet.id
    assign_public_ip = true
    display_name = "vm1-vnic"
  }

  source_details {
    source_type = "image"
    image_id    = var.ubuntu_image_id
  }
}

# VM2
resource "oci_core_instance" "vm2" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  shape               = var.vm_shape
  display_name        = "vm2"

  create_vnic_details {
    subnet_id = oci_core_subnet.lab_subnet.id
    assign_public_ip = true
    display_name = "vm2-vnic"
  }

  source_details {
    source_type = "image"
    image_id    = var.ubuntu_image_id
  }
}

output "vm1_private_ip" {
  value = oci_core_instance.vm1.private_ip
}

output "vm2_private_ip" {
  value = oci_core_instance.vm2.private_ip
}
