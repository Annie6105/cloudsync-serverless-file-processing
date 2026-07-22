# modules/compute/main.tf
# ─────────────────────────────────────────────────────────────
# Módulo: Compute
# Crea la Lambda, su IAM Role y los permisos necesarios.
# ─────────────────────────────────────────────────────────────

# ── Zipear el código de la Lambda automáticamente ───────────
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.root}/../../lambda/processor"
  output_path = "${path.module}/lambda_payload.zip"
}

# ── IAM Role — identidad de la Lambda ───────────────────────
resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-${var.environment}-lambda-role"

  # Trust policy: solo Lambda puede asumir este rol
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "lambda.amazonaws.com" }
      }
    ]
  })

  tags = merge(var.tags, {
    Module = "compute"
  })
}

# ── IAM Policy — permisos que tiene la Lambda ───────────────
resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.project_name}-${var.environment}-lambda-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CloudWatchLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },


      {
        Sid    = "S3Access"
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:DeleteObject"
        ]

        Resource = [
          var.source_bucket_arn,
          "${var.source_bucket_arn}/*",
          var.processed_bucket_arn,
          "${var.processed_bucket_arn}/*"
        ]
      }
    ]
  })
}

# ── Lambda Function ──────────────────────────────────────────
resource "aws_lambda_function" "processor" {
  function_name    = "${var.project_name}-${var.environment}-processor"
  role             = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  timeout          = 30
  memory_size      = 128

  environment {
    variables = {

      ENVIRONMENT = var.environment

      PROCESSED_BUCKET = var.processed_bucket_name

    }
  }

  tags = merge(var.tags, {
    Module = "compute"
  })
}

# ── Permiso: S3 puede invocar esta Lambda ───────────────────
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.source_bucket_arn
}