#cloud-config
hostname: ${hostname}
fqdn: ${fqdn}
packages:
  - python3

runcmd:
  # Alterando a porta do serviço SSH
  - | 
    sed -i 's/#Port 22/Port '"${ssh_port}"'/' /etc/ssh/sshd_config
    grep -qxF 'Port '"${ssh_port}"'' /etc/ssh/sshd_config || echo 'Port '"${ssh_port}"'' >> /etc/ssh/sshd_config
    systemctl enable ssh
    systemctl restart ssh

users:
  - name: root
    # Para definir a senha de um usuario que ja existe é necessário usar o parametro hashed_passwd
    hashed_passwd: ${root_passwd}
    lock_passwd: false
    shell: /bin/bash
  - name: ${user_name}
    # Para definir a senha de um novo usuario é necessário usar o parametro passwd
    passwd: ${user_passwd}
    groups: users,sudo
    lock_passwd: true
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/sh
    ssh_authorized_keys:
      - ${user_ssh_rsa}