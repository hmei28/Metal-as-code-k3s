// matchbox
module "matchbox" {
  source = "git::https://github.com/hmei28/terraform-matchbox-k3s.git"
  matchbox_http_endpoint = var.matchbox_http_endpoint
  ssh_authorized_key = var.ssh_authorized_key
  os_version = var.os_version
  disk = var.disk
  k3s_token = var.k3s_token
  k3s_version = var.k3s_version
  k3s_cluster_domain = var.k3s_cluster_domain
  k3s_tls_san = var.k3s_tls_san
  k3s_database = var.k3s_database
  k3s_disable_components = var.k3s_disable_components
  k3s_servers = var.k3s_servers
  k3s_agents = var.k3s_agents
}