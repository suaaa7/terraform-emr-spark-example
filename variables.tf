# Region to build the EMR cluster in
# If this is changed you MUST update emr_config_mangement_cidr_blocks
variable "region" {
  default = "us-west-2"
}

# Note: These change from region-to-region.  See README for details.
variable "sns_source_addresses" {
  type = "list"

  default = [
    "205.251.233.160/28",
    "205.251.233.176/29",
    "205.251.233.32/28",
    "205.251.233.48/29",
    "205.251.234.32/28",
    "54.240.230.176/29",
    "54.240.230.240/29",
  ]
}

# The Size of the Master
variable "master_instance_type" {
  default = "r4.xlarge"
}

# The Size of the Core Node
variable "core_instance_type" {
  default = "r4.xlarge"
}

# The initial number of instances to start
variable "core_instance_count_min" {
  default = 1
}

# The maximum number of core nodes to scale up to
variable "core_instance_count_max" {
  default = 3
}

# The EMR release, see: https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-5x.html
variable "emr_release" {
  default = "emr-5.13.0"
}

# The size (in GB) where HDFS will store it's data
variable "core_volume_size" {
  default = 100
}

# The size (in GB) the root filesystem will be
variable "root_volume_size" {
  default = 100
}

# The port that Zeppelin runs on
variable "zeppelin_port" {
  default = 8893
}

# A name for the cluster.  Most AWS resources created will contain this name for easy identification
variable "cluster_name" {}

# The VPC in which to create the EMR cluster, subnet IDs will be inferred.  See "Security Module" in the README
variable "vpc_id" {}

