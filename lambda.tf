data "archive_file" "lambda_zip_file" {
  # source_dir  = "${path.cwd}/zip_files/"
  type          = local.compress_type
  source_file   = local.lambda_source_file
  output_path   = local.lambda_output_path
}
#######################################################
#                   LAMBDA
####################################################### 
resource "aws_lambda_function" "lambda_fn" {
  function_name = var.lambda_function_name

  #filename         = "${path.cwd}/zip_files/lambda_function.zip"
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





# resource "aws_lambda_layer_version" "usmis-jwtverifier" {
#   filename   = "./lambda_dist_zip/usmis-jwtverifier-layer.zip"
#   layer_name = "usmis-jwtverifier"
#   skip_destroy = false

#   compatible_runtimes      = ["python3.9"]
#   compatible_architectures = ["x86_64"]

#   depends_on = [
#     data.archive_file.usmis-jwtverifier-package
#   ]
# }

# data "archive_file" "usmis-jwtverifier-package" {
#   type        = "zip"
#   source_dir  = "${path.cwd}/lambda_dist_pkg/"
#   output_path = "lambda_dist_zip/usmis-jwtverifier-layer.zip"

#   depends_on = [
#     null_resource.null-usmis-jwtverifier-package
#   ]
# }

# resource "null_resource" "null-usmis-jwtverifier-package" {
#   triggers = { update_at = timestamp() }
#   provisioner "local-exec" {
#     command = <<EOT
# rm -rf python
# mkdir -p python
# pip install --upgrade --target ../lambda_dist_pkg/python okta-jwt-verifier
# pip install --upgrade --target ../lambda_dist_pkg/python pyjwt
# rm -r python/py
# rm -r python/py-1.11.0.dist-info
# EOT
#     interpreter = ["bash", "-c"]
#     working_dir = "${path.cwd}/lambda_dist_pkg/"
#   }
# }
# resource "null_resource" "null_code_to_zip" {
#   triggers = { update_at = timestamp() }
#   provisioner "local-exec" {
#     command = <<EOT
# zip a lambda_function.zip ${path.cwd}/code/lambda_function.py -r
# EOT
#     interpreter = ["bash", "-c"]
#     working_dir = "${path.cwd}/zip_files/"
#   }
# }

