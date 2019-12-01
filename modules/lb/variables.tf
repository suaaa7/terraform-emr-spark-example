variable "cluster_name" {
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
}

variable "lb_security_group" {
}

variable "zeppelin_port" {
}

variable "master_id" {
}

variable "lb_cert_arn" {
}
