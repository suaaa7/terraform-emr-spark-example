terraform {
  required_version = ">= 0.12.6"

  required_providers {
    archive  = "~> 1.3.0"
    aws      = "~> 2.40.0"
    http     = "~> 1.1.1"
    local    = "~> 1.4.0"
    random   = "~> 2.2.1"
    template = "~> 2.1.2"
    tls      = "~> 2.1.1"
  }
}

provider "aws" {
  region = var.region
}
