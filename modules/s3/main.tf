resource "aws_s3_bucket" "s3_logs_bucket" {
  bucket        = "${var.cluster_name}-${var.region}-${terraform.workspace}-s3logs"
  acl           = "log-delivery-write"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.cluster_name}-${var.region}-${terraform.workspace}"
  acl           = "private"
  force_destroy = true

  logging {
    target_bucket = aws_s3_bucket.s3_logs_bucket.id
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
