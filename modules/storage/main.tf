# ============================================================
# CloudSync – Storage Module
# Creates:
# 1. Uploads Bucket
# 2. Processed Bucket
# 3. Lambda Trigger
# ============================================================

############################
# Uploads Bucket
############################

resource "aws_s3_bucket" "uploads" {
  bucket = var.uploads_bucket_name

  tags = merge(var.tags, {
    Name = "Uploads Bucket"
  })
}

resource "aws_s3_bucket_public_access_block" "uploads" {
  bucket = aws_s3_bucket.uploads.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "uploads" {
  bucket = aws_s3_bucket.uploads.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

############################
# Processed Bucket
############################

resource "aws_s3_bucket" "processed" {
  bucket = var.processed_bucket_name

  tags = merge(var.tags, {
    Name = "Processed Bucket"
  })
}

resource "aws_s3_bucket_public_access_block" "processed" {
  bucket = aws_s3_bucket.processed.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "processed" {
  bucket = aws_s3_bucket.processed.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

############################
# S3 → Lambda Trigger
############################

resource "aws_s3_bucket_notification" "uploads_trigger" {
  bucket = aws_s3_bucket.uploads.id

  lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*"]

    filter_prefix = var.trigger_prefix
    filter_suffix = var.trigger_suffix
  }

  depends_on = [var.lambda_permission_id]
}