output "master_id" {
  value = data.aws_instance.master.id
}

output "master_dns_name" {
  value = data.aws_instance.master.public_dns
}

output "cluster_id" {
  value = aws_emr_cluster.cluster.id
}
