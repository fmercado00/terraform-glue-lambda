data "archive_file" "lambda_zip_file" {
  type          = local.compress_type
  source_file   = local.lambda_source_file
  output_path   = local.lambda_output_path
}
#######################################################
#                   LAMBDA
####################################################### 
resource "aws_lambda_function" "lambda_fn" {
  function_name = var.lambda_function_name

  filename          = data.archive_file.lambda_zip_file.output_path
  source_code_hash  = data.archive_file.lambda_zip_file.output_base64sha256
  role              = aws_iam_role.role.arn
  runtime           = var.lambda_runtime
  handler           = "lambda_function.lambda_handler"
  timeout           = var.lambda_timeout

  depends_on = [
      data.archive_file.lambda_zip_file,
      aws_iam_role_policy_attachment.attachment,
      aws_cloudwatch_log_group.lambda_log_group,
    ]
}

