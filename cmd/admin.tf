provider "aws" {
  region = "eu-west-1"
}

variable "admin_ssh_key" {
  description = "ssh key"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCb5J7XJS2p9+1udlNs2sec8SgCm+dCEGzWlrxGA/YFU7mVcGWtKbmiXJEMdboRWO7qnjyQAAKC0WZTu3yK/ubIqgJDuGL9WkSaFhucCUy5JUYEGMG2kUlC7mgtYcr4db11LmgL27k2AuyTErdU6+Kj8NqPBRennMEX+B8tYrXn+p/bSXizlDXc49iYfEOInDY7xuKhy5mMIOBmPh+aTEa5TqLimrRUuTk6KZ4/K3C/QuPuOq3Ks6yUkGsNAU9oVD5+1uPe6fJvrT1KdAj3mae/bJzegq8GQAU50SODyo8qkw1OtPFzDmVwkEtdq0p298DL4o1OaElHIEoypfr08+Dx nixlike@oleksiis-mbp-3.kyiv.epam.com"
}

data "http" "workstationip" {
  url = "https://ifconfig.co"
}

variable "public_domain" {
  description = "Public domain name used as parent for all environments"
  default     = "lab.certacloud.io"
}
