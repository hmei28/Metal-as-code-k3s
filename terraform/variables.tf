variable "k3s_servers" {
  type = list(object({
    name   = string
    mac    = string
    ip     = string
  }))
  default = [
    {
      name = "dummy"
      mac = "dummy"
      ip = "dummy"
    }
  ]
  description = <<EOD
List of server machine details (unique name, identifying MAC address)
[{ name = "server1", mac = "52:54:00:a1:9c:ae", ip = "192.168.1.1"}]
EOD
}

variable "k3s_agents" {
  type = list(object({
    name   = string
    mac    = string
    ip     = string
  }))
  default = [
    {
      name = "dummy"
      mac = "dummy"
      ip = "dummy"
    }
  ]
  description = <<EOD
List of agent machine details (unique name, identifying MAC address)
[
  { name = "agent1", mac = "52:54:00:b2:2f:86", ip = "192.168.1.2"},
  { name = "agent2", mac = "52:54:00:c3:61:77", ip = "192.168.1.3"}
]
EOD
}

variable "matchbox_http_endpoint" {
  type        = string
  description = "Matchbox HTTP read-only endpoint (e.g. http://matchbox.example.com:8080)"
}

variable "matchbox_rpc_endpoint" {
  type        = string
  description = "Matchbox gRPC API endpoint, without the protocol (e.g. matchbox.example.com:8081)"
}

variable "ssh_authorized_key" {
  type        = string
  description = "SSH public key to set as an authorized_key on machines"
}

variable "os_version" {
  type        = string
  description = "version of flatcar"
  default     = "3510.2.5"
}

variable "disk" {
  type        = string
  description = "sda or vda"
  default     = "/dev/vda"
}

variable "k3s_token" {
  type        = string
  description = "k3s token (e.g. demd3.sdfkixklcxtmnzf9)"
}

variable "k3s_version" {
  type        = string
  description = "k3s version (e.g. v1.27.3+k3s1)"
  default     = "v1.27.3+k3s1"
}

variable "k3s_cluster_domain" {
  type        = string
  description = "Cluster default domain base"
  default     = "cluster.local"
}

variable "k3s_tls_san" {
  type        = string
  description = "additional hostnames or IP addresses as Subject Alternative Names on the server TLS cert. separated by commas"
  default     = ""
}

variable "k3s_disable_components" {
  type        = list
  description = "Do not deploy packaged components (coredns, servicelb, traefik, local-storage, metrics-server). Separated by commas"
  default     = []
}

variable "k3s_database" {
  type        = string
  description = "Specify etcd, Mysql, Postgres, or Sqlite"
  default     = "sqlite"
}