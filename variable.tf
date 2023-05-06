variable "ssh_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbzPg4Khr6ZLuYCTlNJd1qBsdKMTrdWBN/20jh4mdqn4+LnE+WTzvInvt93jyqwDldyD+kn37QS1c8cRu0SYaQvyIkh3c9ocELbgDCmB/N969HNmr5tw1TuUiLrOzyLxM2mSa4HOCcnq6YBe3I30g9sU0TxzdXh2XV8NiG0ZzZ1m7JdmO1aYmgy7Ii6vFvqC6JmE90/shEmsqoiIDTON1uhW7kK3fovnEqdRjQT5WeBj4TvIvM2R79IsllNhhM22/XGrkoqJsBWkEjA7zN8Xm4rRB3jXSRVQrlsMyPWaCHVUFxd02AAbnmi6KrccoZMppzyvNuAJp2HAlDVhSkfRX7j5LOxUROZQIcworji1Y2qpwAN1rOpfaZWifWhj42+HZisjc7/mKpKNa3DoXVJZuZlDASbQek8eOcGY4gJzgFxp9mwNhb+duSrUQM8ya1TKvYP2QBRBxMn/4vz1WmlqKVOpBK8V1839CP2m9CUgqotHzsoojZnz7eqFO2W2+8Juc= newkey@gbansible"
}
variable "proxmox_host" {
  type = string
  default = "px"
}
variable "template_name" {
  type = string  
  default = "suse-15.4-template"
}