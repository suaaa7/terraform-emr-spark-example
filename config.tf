terraform {
  required_version = ">= 0.12.6"
}

provider "aws" {
  region  = var.region
  version = "~> 2.40.0"
}

provider "random" {
  version = "~> 2.2.1"
}

provider "template" {
  version = "~> 2.1.2"
}

provider "archive" {
  version = "~> 1.3.0"
}

provider "tls" {
  version = "~> 2.1.1"
}

provider "http" {
  version = "~> 1.1.1"
}

provider "local" {
  version = "~> 1.4.0"
}
