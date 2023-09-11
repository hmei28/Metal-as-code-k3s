// Configure the matchbox provider
provider "matchbox" {
  endpoint    = var.matchbox_rpc_endpoint
  client_cert = file("~/.matchbox/client.crt")
  client_key  = file("~/.matchbox/client.key")
  ca          = file("~/.matchbox/ca.crt")
}

provider "openwrt" {
  # Configuration options
  hostname  =  var.openwrt_hostname
  password  =  var.openwrt_password
  username  =  var.openwrt_username
  port      =  var.openwrt_port
}

terraform {
  required_providers {
        ct = {
      source  = "poseidon/ct"
      version = "0.11.0"
    }
    matchbox = {
      source  = "poseidon/matchbox"
      version = "0.5.2"
    }
    openwrt = {
      source = "joneshf/openwrt"
      version = "0.0.20"
    }
  }
}