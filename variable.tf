variable "ssh_key" {
  type = string
  default = "your-ssh-key"
}
variable "proxmox_host" {
  type = string
  default = "px"
}
variable "template_name" {
  type = string  
  default = "deb-11-cloudinit-temp"
}