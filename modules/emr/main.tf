data "template_file" "configuration" {
  template = "${file("${path.module}/templates/configuration.json.tpl")}"

  vars = {
    zeppelin_port               = "${var.zeppelin_port}"
    zeppelin_keystore_password  = "${var.zeppelin_keystore_password}"
    zeppelin_notebook_s3_bucket = "${var.s3_bucket}"
  }
}

data "template_file" "security_configuration" {
  template = "${file("${path.module}/templates/security_configuration.json.tpl")}"

  vars = {
    kms_key_id      = "${var.kms_key_id}"
    certs_s3_object = "${var.certs_s3_object}"
  }
}

resource "aws_emr_security_configuration" "security_configuration" {
  name = "${var.cluster_name}-${terraform.env}"

  configuration = "${data.template_file.security_configuration.rendered}"
}

data "template_file" "autoscaling_policy" {
  template = "${file("${path.module}/templates/autoscaling_policy.json.tpl")}"

  vars = {
    min_capacity = "${var.core_instance_count_min}"
    max_capacity = "${var.core_instance_count_max}"
  }
}

resource "aws_emr_cluster" "cluster" {
  name          = "${var.cluster_name}-${terraform.env}"
  release_label = "${var.release}"
  applications  = ["Spark", "Zeppelin", "Hadoop", "Ganglia"]
  log_uri       = "s3n://${var.s3_bucket}/logs/"

  termination_protection            = false
  keep_job_flow_alive_when_no_steps = true

  ebs_root_volume_size = "${var.root_volume_size}"

  ec2_attributes {
    subnet_id                         = "${var.subnet_id}"
    emr_managed_master_security_group = "${var.master_security_group}"
    emr_managed_slave_security_group  = "${var.core_security_group}"
    instance_profile                  = "${var.instance_profile}"
    key_name                          = "${var.ssh_key_name}"
  }

  instance_group {
    instance_role  = "MASTER"
    instance_type  = "${var.master_instance_type}"
    instance_count = 1
  }

  instance_group {
    instance_role  = "CORE"
    instance_type  = "${var.core_instance_type}"
    instance_count = "${var.core_instance_count_min}"

    ebs_config {
      size = "${var.core_volume_size}"
      type = "gp2"
    }

    autoscaling_policy = "${data.template_file.autoscaling_policy.rendered}"
  }

  tags {
    Name        = "${var.cluster_name}-${terraform.env}"
    Environment = "${terraform.env}"
    Region      = "${var.region}"
  }

  service_role           = "${var.service_role}"
  autoscaling_role       = "${var.autoscaling_role}"
  security_configuration = "${aws_emr_security_configuration.security_configuration.name}"

  configurations = "${data.template_file.configuration.rendered}"

  bootstrap_action {
    path = "${var.bootstrap_script_s3_object}"
    name = "configure_system"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_instance" "master" {
  filter {
    name   = "dns-name"
    values = ["${aws_emr_cluster.cluster.master_public_dns}"]
  }
}
