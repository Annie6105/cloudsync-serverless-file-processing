variable "uploads_bucket_name" {
  description = "Name of the uploads S3 bucket"
  type        = string
}

variable "processed_bucket_name" {
  description = "Name of the processed S3 bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning"
  type        = bool
  default     = false
}

variable "lambda_arn" {
  description = "Lambda ARN"
  type        = string
}

variable "lambda_permission_id" {
  description = "Lambda permission ID"
  type        = string
}

variable "trigger_prefix" {
  description = "Trigger prefix"
  type        = string
  default     = ""
}

variable "trigger_suffix" {
  description = "Trigger suffix"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}