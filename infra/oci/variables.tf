variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_id" {}
variable "availability_domain" {}
variable "vm_shape" {
  default = "VM.Standard.E2.1.Micro"
}
variable "ubuntu_image_id" {}
variable "my_ip" {}        # your home/public IP
variable "vm1_ip" {}       # VM1 private IP
