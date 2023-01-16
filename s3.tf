#######################################################
#                   S3 Source Bucket
####################################################### 
resource "aws_s3_bucket" "source_bucket" {
  bucket = var.bucket_source_name
}

resource "aws_s3_bucket_acl" "source_bucket_acl" {
  bucket = aws_s3_bucket.source_bucket.id
  acl    = var.s3_acl
}

resource "aws_s3_bucket_versioning" "source_bucket_ver" {
  bucket = aws_s3_bucket.source_bucket.id
  versioning_configuration {
    status = var.s3_bucket_versioning
  }
}
#######################################################
#                   S3 Target Bucket
#######################################################
resource "aws_s3_bucket" "target_bucket" {
  bucket = var.bucket_target_name
}

resource "aws_s3_bucket_acl" "target_bucket_acl" {
  bucket = aws_s3_bucket.target_bucket.id
  acl    = var.s3_acl
}

resource "aws_s3_bucket_versioning" "target_bucket_ver" {
  bucket = aws_s3_bucket.target_bucket.id
  versioning_configuration {
    status = var.s3_bucket_versioning
  }
}
#######################################################
#                   S3 lambda permissions
#######################################################
resource "aws_lambda_permission" "allow_s3_invocation" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_fn.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.source_bucket.id}"
}
#######################################################
#                   S3 lambda trigger
#######################################################
resource "aws_s3_bucket_notification" "lambda_fn_trigger" {
  bucket = aws_s3_bucket.source_bucket.id
  lambda_function {
    lambda_function_arn   = aws_lambda_function.lambda_fn.arn
    events                = ["s3:ObjectCreated:*"]
    filter_suffix         = ".csv"
  }
}