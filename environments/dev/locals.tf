# ============================================================
# CloudSync – Environment Locals
# ============================================================

locals {

  project_name = "cloudsync"

  environment = "dev"

  # Upload bucket
  uploads_bucket_name = "${local.project_name}-${local.environment}-uploads-${var.aws_account_id}"

  # Processed bucket
  processed_bucket_name = "${local.project_name}-${local.environment}-processed-${var.aws_account_id}"

  common_tags = {
    Project     = "CloudSync"
    Environment = local.environment
    ManagedBy   = "Terraform"
    Repository  = "cloudsync-serverless-file-processing"
  }

}