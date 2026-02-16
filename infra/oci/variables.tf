variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_id" {}
variable "availability_domain" {}
variable "vm_shape" {
  type = string
  default = "VM.Standard.E2.1.Micro"
  validation {
    condition = contains(["VM.Standard.E2.1.Micro", "VM.Standard.A1.Flex"], var.vm_shape)
    error_message = "Only free-tier shapes allowed."
  }
}
variable "ubuntu_image_id" {}
variable "my_ip" {}        # your home/public IP
variable "vm1_ip" {}       # VM1 private IP
