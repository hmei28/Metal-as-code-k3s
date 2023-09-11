# generate tls san variable
locals {
  k3s_tls_san = join("," ,[for srv in var.k3s_servers : srv.ip])
}

// Default matcher group for machines
resource "matchbox_group" "default" {
  name    = "default"
  profile = matchbox_profile.flatcar-install.name

  metadata = {
    matchbox_http_endpoint = var.matchbox_http_endpoint
    ssh_authorized_key     = var.ssh_authorized_key
    disk                   = var.disk
  }
}

// Match remote installer k3s server
resource "matchbox_group" "k3s_server" {
  count   = length(var.k3s_servers)
  name    = format("%s", var.k3s_servers[count.index].name)
  profile = matchbox_profile.k3s.name
  
  selector = {
    os = "installed"
    mac = var.k3s_servers[count.index].mac
  }
  metadata = {
    matchbox_http_endpoint  = var.matchbox_http_endpoint
    k3s_token               = var.k3s_token
    k3s_server_exec         = "server --cluster-domain ${var.k3s_cluster_domain} --tls-san ${local.k3s_tls_san},${var.k3s_tls_san} ${length(var.k3s_disable_components) > 0 ? "--disable ${join(",", var.k3s_disable_components)}" : ""}"
    k3s_init_cluster        = "${count.index == 0 ? "K3S_CLUSTER_INIT=1" : ""}"
    k3s_url                 = "${count.index != 0 ? "K3S_URL=https://${var.k3s_tls_san != "" ? var.k3s_tls_san : var.k3s_servers[0].ip}:6443" : ""}"
    ssh_authorized_key      = var.ssh_authorized_key
    k3s_version             = var.k3s_version
    k3s_database            = var.k3s_database
  }
}

// Match remote installer k3s
resource "matchbox_group" "k3s_agent" {
  count   = length(var.k3s_agents)
  name    = format("%s", var.k3s_agents[count.index].name)
  profile = matchbox_profile.k3s.name
  
  selector = {
    os = "installed"
    mac = var.k3s_agents[count.index].mac
  }
  metadata = {
    matchbox_http_endpoint  = var.matchbox_http_endpoint
    k3s_token               = var.k3s_token
    k3s_server_exec         = "agent"
    k3s_url                 = "K3S_URL=https://${var.k3s_tls_san != "" ? var.k3s_tls_san : var.k3s_servers[0].ip}:6443"
    k3s_init_cluster        = ""
    ssh_authorized_key      = var.ssh_authorized_key
    k3s_version             = var.k3s_version
    k3s_database            = var.k3s_database
  }
}