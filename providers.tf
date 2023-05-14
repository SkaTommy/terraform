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
  pm_api_url = "https://your-domain:8006/api2/json"
##### токен id который создан заранее 
  pm_api_token_id = "your@pam!your-token"
##### ссекрет токен полученный при создании токен id
  pm_api_token_secret = "your-secrets"
  pm_tls_insecure = true
}