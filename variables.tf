##################################################################################################################
################################################# AUTHENTICATION #################################################
##################################################################################################################


variable "nutanix_endpoint" {
  description = "IP address of Nutanix Cluster"
  default     = "192.168.100.10"
}


variable "nutanix_port" {
  description = "Nutanix cluster port"
  default     = "9440"
}


##################################################################################################################
#################################################### GENERAL #####################################################
##################################################################################################################


variable "cluster_id" {
  description = "ID of Nuntanix Cluster"
  default     = ""
}


variable "owner" {
  description = "Name of Terrraform Owner"
  default     = "Paulo Xavier"
}


variable "provisioner" {
  description = "Name of provisioner"
  default     = "Terraform"
}


variable "timezone" {
  description = "Set VM Nutanix Timezone"
  default     = "America/Fortaleza"
}


##################################################################################################################
###################################################### USERS #####################################################
##################################################################################################################


variable "root_passwd" {
  description = "Define root password"
  default     = ""
}


variable "user_name" {
  description = "Define local user name"
  default     = "ubuntu"
}


variable "user_passwd" {
  description = "Define local user password"
  default     = ""
}


##################################################################################################################
################################################# VIRTUAL MACHINE ################################################
##################################################################################################################


variable "vm_qtd_replicas" {
  description = "How many copies will be created"
  default     = 3
}


variable "vm_name" {
  description = "VM Name"
  default     = "vm-server-"
}


variable "vm_domain" {
  description = "VM Domain"
  default     = ".meudominio.local"
}


variable "vm_subnet_name" {
  description = "Name of Subnet"
  default     = ""
}


variable "vm_subnet_uuid" {
  description = "UUID of Subnet"
  default     = ""
}


variable "vm_ssh_port" {
  description = "Set SSH Port"
  default     = 2200
}


variable "vm_qtd_vcpu" {
  description = "How many vCPUs are in VM"
  default     = 1
}


variable "vm_qtd_vcpu_sockets" {
  description = "How many sockets are in each vCPUs"
  default     = 2
}


variable "vm_qtd_memory" {
  description = "How many memory are in VM"
  default     = 8192
}


variable "image_name" {
  description = "Name of OS image"
  default     = "ubuntu 22.04 x64 - cloudimage.img"
}


variable "vm_disk_sizes" {
  description = "Set disk size in MB"
  default     = 1024 * 100
}