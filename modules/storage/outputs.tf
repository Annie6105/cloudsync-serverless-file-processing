output "uploads_bucket_id" {
  value = aws_s3_bucket.uploads.id
}

output "uploads_bucket_arn" {
  value = aws_s3_bucket.uploads.arn
}

output "uploads_bucket_name" {
  value = aws_s3_bucket.uploads.bucket
}

output "processed_bucket_id" {
  value = aws_s3_bucket.processed.id
}

output "processed_bucket_arn" {
  value = aws_s3_bucket.processed.arn
}

output "processed_bucket_name" {
  value = aws_s3_bucket.processed.bucket
}