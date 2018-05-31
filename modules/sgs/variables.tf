variable "cluster_name" {}

variable "subnet_ids" {
  type = "list"
}

variable "sns_source_addresses" {
  type = "list"
}

variable "zeppelin_port" {}

variable "whitelist_ips" {
  type = "list"
}
