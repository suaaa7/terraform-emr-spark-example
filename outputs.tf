output "dns_name" {
  value = module.lb.dns_name
}

output "master_dns_name" {
  value = module.emr.master_dns_name
}

output "cluster_id" {
  value = module.emr.cluster_id
}
