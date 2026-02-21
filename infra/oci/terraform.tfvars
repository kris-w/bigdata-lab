############################################
# terraform.tfvars
# Replace these values with your own.
############################################

tenancy_ocid        = "ocid1.tenancy.oc1..aaaaaaaaajoe3z5ls5wcns6ghpjs3hi7ym4woglyxifj7ceydbm662ln3o3a"
user_ocid           = "ocid1.user.oc1..aaaaaaaaobpyb4icski3k63at6qmvet7wowous57hs25dfgncu5fsrxfbwhq"
fingerprint         = "38:77:02:46:d9:8d:8e:e1:3c:13:ba:bb:71:d0:7c:52"
private_key_path    = "~/.oci/oci_api_key.pem"

region              = "ca-montreal-1"
compartment_id      = "ocid1.tenancy.oc1..aaaaaaaaajoe3z5ls5wcns6ghpjs3hi7ym4woglyxifj7ceydbm662ln3o3a"
availability_domain = "wNOU:CA-MONTREAL-1-AD-1"

# Always Free compute shape
vm_shape            = "VM.Standard.E2.1.Micro"

# Ubuntu image OCID for your region
ubuntu_image_id     = "ocid1.image.oc1.ca-montreal-1.aaaaaaaakcgu66pvsdge4ibmtg2kt77l72x5sqix5hflhii5dnmejuvuynra"

# Connect key
ssh_public_key      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWVmBkjQhmY2MR8CEReFsKilWmgV8qFjeDp/VbU0vXW bigdata-lab"

# Networking
my_ip               = "24.212.185.198"
vm1_ip              = "10.0.1.10"
vm2_ip              = "10.0.1.11"
