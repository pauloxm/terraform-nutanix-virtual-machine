output "ip_address" {
  value     = [for k, v in nutanix_virtual_machine.ntnx-virtual-machine : v.nic_list_status[0].ip_endpoint_list[0].ip]
}

output "ssh_private_pem" {
  value     = [for k, v in tls_private_key.vm_ssh_key : trimspace(v.private_key_pem)]
  sensitive = true
}