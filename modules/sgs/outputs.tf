output "lb_security_group" {
  value = "${aws_security_group.lb_security_group.id}"
}

output "master_security_group" {
  value = "${aws_security_group.master_security_group.id}"
}

output "core_security_group" {
  value = "${aws_security_group.core_security_group.id}"
}
