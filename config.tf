terraform {
  required_version = ">= 0.11.0"
}

provider "aws" "aws" {
  region  = "${var.region}"
  version = "~> 1.20"
}

provider "random" "random" {
  version = "~> 1.1"
}

provider "template" "template" {
  version = "~> 1.0"
}

provider "archive" "archive" {
  version = "~> 1.0"
}

provider "tls" "tls" {
  version = "~> 1.0"
}

provider "http" "http" {
  version = "~> 1.0"
}

provider "local" "local" {
  version = "~> 1.1"
}
