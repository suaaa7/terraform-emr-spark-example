module "sec" {
  source = "./modules/sec"

  cluster_name = "${var.cluster_name}"
  region       = "${var.region}"
  vpc_id       = "${var.vpc_id}"
}

module "sgs" {
  source = "./modules/sgs"

  cluster_name         = "${var.cluster_name}"
  subnet_ids           = "${module.sec.net_subnet_ids}"
  sns_source_addresses = "${var.sns_source_addresses}"
  zeppelin_port        = "${var.zeppelin_port}"
  whitelist_ips        = ["${module.sec.net_whitelist_ip}"]
}

module "s3" {
  source = "./modules/s3"

  cluster_name = "${var.cluster_name}"
  region       = "${var.region}"
}

module "bootstrap" {
  source = "./modules/bootstrap"

  cluster_name                = "${var.cluster_name}"
  region                      = "${var.region}"
  zeppelin_port               = "${var.zeppelin_port}"
  zeppelin_keystore_password  = "${module.sec.zeppelin_keystore_password}"
  zeppelin_certs_archive_path = "${module.sec.zeppelin_certs_archive_path}"
}

module "emr" {
  source = "./modules/emr"

  cluster_name               = "${var.cluster_name}"
  certs_s3_object            = "${module.bootstrap.certs_s3_object}"
  kms_key_id                 = "${module.sec.iam_kms_key_id}"
  release                    = "${var.emr_release}"
  s3_bucket                  = "${module.s3.bucket}"
  root_volume_size           = "${var.root_volume_size}"
  subnet_id                  = "${module.sec.net_subnet_ids[0]}"
  master_security_group      = "${module.sgs.master_security_group}"
  core_security_group        = "${module.sgs.core_security_group}"
  instance_profile           = "${module.sec.iam_instance_profile}"
  autoscaling_role           = "${module.sec.iam_autoscaling_role}"
  ssh_key_name               = "${module.sec.ssh_key_name}"
  master_instance_type       = "${var.master_instance_type}"
  core_instance_type         = "${var.core_instance_type}"
  core_instance_count_min    = "${var.core_instance_count_min}"
  core_instance_count_max    = "${var.core_instance_count_max}"
  core_volume_size           = "${var.core_volume_size}"
  service_role               = "${module.sec.iam_service_role}"
  zeppelin_port              = "${var.zeppelin_port}"
  zeppelin_keystore_password = "${module.sec.zeppelin_keystore_password}"
  bootstrap_script_s3_object = "${module.bootstrap.bootstrap_script_s3_object}"
  region                     = "${var.region}"
}

module "lb" {
  source = "./modules/lb"

  cluster_name      = "${var.cluster_name}"
  vpc_id            = "${var.vpc_id}"
  subnet_ids        = "${module.sec.net_subnet_ids}"
  lb_security_group = "${module.sgs.lb_security_group}"
  zeppelin_port     = "${var.zeppelin_port}"
  master_id         = "${module.emr.master_id}"
  lb_cert_arn       = "${module.sec.zeppelin_public_cert_arn}"
}
