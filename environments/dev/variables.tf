variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "enable_versioning" {
  description = "Enable S3 Versioning"
  type        = bool
  default     = false
}

variable "trigger_prefix" {
  description = "Trigger Prefix"
  type        = string
  default     = ""
}

variable "trigger_suffix" {
  description = "Trigger Suffix"
  type        = string
  default     = ""
}