## IAM Outputs ##

output "iam_service_role" {
  value = "${aws_iam_role.service_role.id}"
}

output "iam_instance_profile" {
  value = "${aws_iam_instamce_profile.instance_profile.id}"
}

output "iam_autoscaling_role" {
  value = "${aws_iam_role.autoscaling_role.id}"
}

output "iam_kms_key_id" {
  value = "${aws_kms_key.key.key_id}"
}

## Net Outputs ##

output "net_whitelist_ip" {
  value = ["${chomp(data.http.ip.body)}/32"]
}

output "net_subnet_ids" {
  value = "${data.aws_subnet_ids.subnet_ids.ids}"
}

## SSH Outputs ##

output "ssh_key_name" {
  value = "${aws_key_pair.key_pair.key_name}"
}

## Zepplein Outputs ##

output "zeppelin_certs_archive_path" {
  depends_on = ["data.archive_file.certs"]

  value = "${var.certs_path}/certs.zip"
}

output "zeppelin_keystore_password" {
  value = "${random_string.zeppelin_keystore_password.result}"
}

output "zeppelin_public_cert_arn" {
  value = "${aws_iam_server_certificate.public_cert.arn}"
}
