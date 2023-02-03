resource "null_resource" "null_import_resources" {
  triggers = { update_at = timestamp() }
  provisioner "local-exec" {
    command = <<EOT
terraform import aws_s3_bucket.source_bucket demo-glue-lambda-source0406
EOT
    interpreter = ["bash", "-c"]
    working_dir = "${path.cwd}/zip_files/"
  }
}