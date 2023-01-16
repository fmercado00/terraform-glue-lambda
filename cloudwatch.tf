#######################################################
#                   CLoudWatch                                               
####################################################### 
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "job_log_group" {
  name              = "/aws/glue/${var.job_name}"
  retention_in_days = 14
}