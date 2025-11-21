data "nutanix_image" "vm" {
  image_name = var.image_name
}

# Create RSA key of size 4096 bits for each Virtual Machine
resource "tls_private_key" "vm_ssh_key" {

  count = var.vm_qtd_replicas

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "nutanix_virtual_machine" "ntnx-virtual-machine" {

  count = var.vm_qtd_replicas

  # General Information
  name                    = "${var.vm_name}${count.index + 1}"
  description             = "[${upper(var.vm_name)}${count.index + 1}] Criada por ${var.owner} atraves do ${var.provisioner}"
  num_sockets             = var.vm_qtd_vcpu
  num_vcpus_per_socket    = var.vm_qtd_vcpu_sockets
  memory_size_mib         = var.vm_qtd_memory
  hardware_clock_timezone = var.timezone

  # Call cloud-init script
  guest_customization_cloud_init_user_data = base64encode(templatefile("${path.module}/cloud-config.yml.tpl", {
    hostname     = "${var.vm_name}${count.index + 1}"
    fqdn         = "${var.vm_name}${count.index + 1}${var.vm_domain}"
    root_passwd  = var.root_passwd
    user_name    = var.user_name
    user_passwd  = var.user_passwd
    user_ssh_rsa = tls_private_key.vm_ssh_key[count.index].public_key_openssh
    ssh_port     = var.vm_ssh_port
  }))

  # Cluster where the VM will be locate
  cluster_uuid = var.cluster_id

  # Disk configuration
  disk_list {
    disk_size_mib = var.vm_disk_sizes
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.vm.id
    }

    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }

      device_type = "DISK"
    }
  }

  # Network Configuration
  nic_list {
    subnet_name = var.vm_subnet_name
    subnet_uuid = var.vm_subnet_uuid

  }

}

# Create Private Key files for SSH connection
resource "local_file" "private_key" {
  count           = var.vm_qtd_replicas
  content         = tls_private_key.vm_ssh_key[count.index].private_key_openssh
  filename        = "${path.module}/${var.vm_name}${count.index + 1}.pem"
  file_permission = 0600
}