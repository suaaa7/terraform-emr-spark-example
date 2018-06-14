data "http" "ip" {
  url = "${var.ip_lookup_url}"
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = "${var.vpc_id}"
}
