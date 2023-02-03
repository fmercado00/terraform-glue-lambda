resource "aws_s3_object" "file_upload" {
  bucket = var.bucket_source_name
  key    = "demo_glue_job_code.py"
  source = local.glue_py_source_code
  etag   = filemd5(local.glue_py_source_code)
    depends_on = [
      null_resource.null_import_resources,
    ]
}

#######################################################
#                   GLUE JOB                         
####################################################### 
resource "aws_glue_job" "glue_job" {
  name              = var.job_name
  role_arn          = aws_iam_role.role.arn
  worker_type       = var.job_type
  number_of_workers = var.job_number_of_workers
  timeout           = var.job_timeout
  glue_version      = "4.0"

  default_arguments = {
    "--file" = "sample1.csv"
    "--bucket" = "demo-glue-lambda-source0406"
  }

  command {
    script_location = "s3://${aws_s3_bucket.source_bucket.bucket}/${var.job_python_name}"
  }

  depends_on = [
     aws_s3_object.file_upload
  ]
  
}

