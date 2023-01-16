#######################################################
#                   S3 Source Bucket
####################################################### 
resource "aws_s3_bucket" "demogluelambdasource0406" {
  bucket = var.bucket_source_name
}

resource "aws_s3_bucket_acl" "demogluelambdasource0406_acl" {
  bucket = aws_s3_bucket.demogluelambdasource0406.id
  acl    = var.s3_acl
}

resource "aws_s3_bucket_versioning" "demogluelambdasource0406_ver" {
  bucket = aws_s3_bucket.demogluelambdasource0406.id
  versioning_configuration {
    status = var.s3_bucket_versioning
  }
}
#######################################################
#                   S3 Target Bucket
#######################################################
resource "aws_s3_bucket" "demogluelambdatarget0406" {
  bucket = var.bucket_target_name
}

resource "aws_s3_bucket_acl" "demogluelambdatarget0406_acl" {
  bucket = aws_s3_bucket.demogluelambdatarget0406.id
  acl    = var.s3_acl
}

resource "aws_s3_bucket_versioning" "demogluelambdatarget0406_ver" {
  bucket = aws_s3_bucket.demogluelambdatarget0406.id
  versioning_configuration {
    status = var.s3_bucket_versioning
  }
}
#######################################################
#                   S3 lambda permissions
#######################################################
resource "aws_lambda_permission" "demo_allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_fn.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.demogluelambdasource0406.id}"
}
#######################################################
#                   S3 lambda trigger
#######################################################
resource "aws_s3_bucket_notification" "lambda_fn_trigger" {
  bucket = aws_s3_bucket.demogluelambdasource0406.id
  lambda_function {
    lambda_function_arn   = aws_lambda_function.lambda_fn.arn
    events                = ["s3:ObjectCreated:*"]
    filter_suffix         = ".csv"
  }
}