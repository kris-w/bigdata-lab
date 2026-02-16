############################################
# Copy this file to terraform.tfvars
# and replace all values with your own.
############################################

tenancy_ocid        = "YOUR_TENANCY_OCID"
user_ocid           = "YOUR_USER_OCID"
fingerprint         = "YOUR_API_KEY_FINGERPRINT"
private_key_path    = "~/.oci/oci_api_key.pem"

region              = "YOUR_REGION"
compartment_id      = "YOUR_COMPARTMENT_OCID"
availability_domain = "YOUR_AVAILABILITY_DOMAIN"

# Always Free compute shape
vm_shape            = "VM.Standard.E2.1.Micro"

# Ubuntu image OCID for your region
ubuntu_image_id     = "YOUR_UBUNTU_IMAGE_OCID"

# Networking
my_ip               = "YOUR_HOME_IP/32"
vm1_ip              = "10.0.1.10"