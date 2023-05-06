terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.4"
    }
  }
}

provider "proxmox" {
# адрес proxmox сервера
  pm_api_url = "https://pve.sts:8006/api2/json"
# токен id который создан заранее 
  pm_api_token_id = "sts@pam!sts_token"
# ссекрет токен полученный при создании токен id
  pm_api_token_secret = "b54c890e-2ab3-4e27-9b0c-3d47e9611cbe"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "srv_test" {
# кол-во создоваемых машин
  count = 1
# имена  
  name = "vps-sts-${count.index + 1}"
  desc = "terraform deploy"
  vmid = "40${count.index + 1}"
# имя ноды куда будет установлена vm     
  target_node = var.proxmox_host
# из какого темплейта будет создана vm  
  clone = var.template_name
  agent = 1

# кол-во ядер  
  cores = 2
  sockets = 1
  cpu = "host"
# ram  
  memory = 2048
# диски  
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "20G"
    type = "scsi"
    storage = "local"
    iothread = 0
  }
  
  # сеть для создания нескольких карт - дублируем
  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  # lifecycle {
  #   ignore_changes = [
  #     network,
  #   ]
  # }

  os_type = "cloud-init"

# ip 
  ipconfig0 = "ip=192.168.0.41/24,gw=192.168.0.1"
  # ipconfig0 = "ip=192.168.0.4${count.index + 1}/24,gw=192.168.0.1"
  nameserver = "8.8.8.8"

# ssh
  ciuser = "root"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

# # переменные
# variable "ssh_key" {
#   default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbzPg4Khr6ZLuYCTlNJd1qBsdKMTrdWBN/20jh4mdqn4+LnE+WTzvInvt93jyqwDldyD+kn37QS1c8cRu0SYaQvyIkh3c9ocELbgDCmB/N969HNmr5tw1TuUiLrOzyLxM2mSa4HOCcnq6YBe3I30g9sU0TxzdXh2XV8NiG0ZzZ1m7JdmO1aYmgy7Ii6vFvqC6JmE90/shEmsqoiIDTON1uhW7kK3fovnEqdRjQT5WeBj4TvIvM2R79IsllNhhM22/XGrkoqJsBWkEjA7zN8Xm4rRB3jXSRVQrlsMyPWaCHVUFxd02AAbnmi6KrccoZMppzyvNuAJp2HAlDVhSkfRX7j5LOxUROZQIcworji1Y2qpwAN1rOpfaZWifWhj42+HZisjc7/mKpKNa3DoXVJZuZlDASbQek8eOcGY4gJzgFxp9mwNhb+duSrUQM8ya1TKvYP2QBRBxMn/4vz1WmlqKVOpBK8V1839CP2m9CUgqotHzsoojZnz7eqFO2W2+8Juc= newkey@gbansible"
# }
# variable "proxmox_host" {
#     default = "px"
# }
# variable "template_name" {
#     default = "suse-15.4-template"
# }
