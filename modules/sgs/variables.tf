variable "cluster_name" {
}

variable "vpc_id" {
}

variable "sns_source_addresses" {
  type = list(string)
}

variable "zeppelin_port" {
}

variable "whitelist_ips" {
  type = list(string)
}
