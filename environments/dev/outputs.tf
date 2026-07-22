# environments/dev/outputs.tf

output "uploads_bucket_name" {
  description = "Name of the uploads S3 bucket"
  value       = module.storage.uploads_bucket_name
}

output "processed_bucket_name" {
  description = "Name of the processed S3 bucket"
  value       = module.storage.processed_bucket_name
}

output "lambda_name" {
  description = "Name of the Lambda function"
  value       = module.compute.lambda_name
}

output "test_command" {
  description = "Command to test the pipeline"
  value       = "aws s3 cp test.json s3://${module.storage.uploads_bucket_name}/"
}