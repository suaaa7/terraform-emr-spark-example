variable "cluster_name" {}

variable "vpc_id" {}

variable "sns_source_addresses" {
  type = "list"
}

variable "zeppelin_port" {}

variable "whitelist_ips" {
  type = "list"
}
