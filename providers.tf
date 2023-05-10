terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.4"
    }
  }
}

provider "proxmox" {
##### адрес proxmox сервера
  pm_api_url = "https://pve.sts:8006/api2/json"
##### токен id который создан заранее 
  pm_api_token_id = "sts@pam!sts_token"
##### ссекрет токен полученный при создании токен id
  pm_api_token_secret = "b54c890e-2ab3-4e27-9b0c-3d47e9611cbe"
  pm_tls_insecure = true
}
