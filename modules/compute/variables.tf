# modules/compute/variables.tf

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "environment" {
  description = "Ambiente: dev, staging, prod"
  type        = string
}



variable "source_bucket_arn" {
  description = "ARN del bucket S3 que dispara la Lambda"
  type        = string
}

variable "processed_bucket_arn" {
  description = "ARN of the processed S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags comunes aplicados a todos los recursos"
  type        = map(string)
  default     = {}
}

variable "processed_bucket_name" {
  description = "Processed bucket name"
  type        = string
}