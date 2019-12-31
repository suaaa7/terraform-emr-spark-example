# Region to build the EMR cluster in
# If this is changed you MUST update emr_config_mangement_cidr_blocks
variable "region" {
  default = "ap-northeast-1"
}

# Note: These change from region-to-region.  See README for details.
variable "sns_source_addresses" {
  type = list(string)

  default = [
    "27.0.1.24/29",
    "27.0.1.152/29",
    "54.240.200.0/24",
    "27.0.3.144/29",
    "27.0.3.152/29",
  ]
}

# The Size of the Master
variable "master_instance_type" {
  default = "r3.xlarge"
}

# The Size of the Core Node
variable "core_instance_type" {
  default = "r3.xlarge"
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
  default = "emr-5.27.0"
}

# The size (in GB) where HDFS will store it's data
variable "core_volume_size" {
  default = 10
}

# The size (in GB) the root filesystem will be
variable "root_volume_size" {
  default = 10
}

# The port that Zeppelin runs on
variable "zeppelin_port" {
  default = 8893
}

# A name for the cluster.  Most AWS resources created will contain this name for easy identification
variable "cluster_name" {
}
