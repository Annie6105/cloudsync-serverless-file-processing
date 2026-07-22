# environments/dev/main.tf
# ─────────────────────────────────────────────────────────────
# Environment: dev
# Ensambla los módulos compute, messaging y storage.
# El orden de declaración importa — compute primero porque
# storage y messaging necesitan sus outputs.
# ─────────────────────────────────────────────────────────────

terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # ── Remote backend ────────────────────────────────────────
  backend "s3" {
    bucket         = "cloudsync-tf-state-991232066873"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
  # Sin profile — funciona tanto en CI como en local
  # si configurás: $env:AWS_PROFILE = "terraform-pipeline"
}

# ── Módulo 1: Compute (Lambda + IAM) ────────────────────────
# Se crea primero porque storage y messaging necesitan
# sus outputs (lambda_arn, lambda_role_arn)
module "compute" {
  source = "../../modules/compute"

  project_name = local.project_name
  environment  = local.environment

  source_bucket_arn     = module.storage.uploads_bucket_arn
  processed_bucket_arn  = module.storage.processed_bucket_arn
  processed_bucket_name = local.processed_bucket_name
  tags                  = local.common_tags
}



# ── Módulo 3: Storage (S3 + trigger) ────────────────────────
# Se declara último porque necesita el lambda_arn
# y el lambda_permission_id del módulo compute
module "storage" {
  source = "../../modules/storage"

  uploads_bucket_name   = local.uploads_bucket_name
  processed_bucket_name = local.processed_bucket_name

  enable_versioning    = var.enable_versioning
  lambda_arn           = module.compute.lambda_arn
  lambda_permission_id = module.compute.lambda_permission_id
  trigger_prefix       = var.trigger_prefix
  trigger_suffix       = var.trigger_suffix
  tags                 = local.common_tags
}