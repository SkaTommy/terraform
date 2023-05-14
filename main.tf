
resource "proxmox_vm_qemu" "k8s" {
##### кол-во создоваемых машин
  count = 1
##### имена  
  name = "master-k8s-${count.index + 1}"
  desc = "terraform deploy"
  ##### vmid = "${count.index + 1}"
##### имя ноды куда будет установлена vm     
  target_node = var.proxmox_host
##### из какого темплейта будет создана vm  
  clone = var.template_name
  agent = 1

##### кол-во ядер  
  cores = 4
  sockets = 1
  cpu = "host"
##### ram  
  memory = 4096
##### диски  
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "20G"
    type = "scsi"
    storage = "local"
    iothread = 0
  }
  
  ##### сеть для создания нескольких карт - дублируем
  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  os_type = "cloud-init"

##### ip 
  ##### ipconfig0 = "ip=192.168.0.41/24,gw=192.168.0.1"
  ipconfig0 = "ip=192.168.0.15${count.index + 1}/24,gw=192.168.0.1"
  nameserver = "8.8.8.8"

##### ssh
  ciuser = "tamim"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}