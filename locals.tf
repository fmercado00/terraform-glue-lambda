locals {
  compress_type         = "zip"
  glue_py_source_code   = "${path.cwd}/code/demo_glue_job_code.py"
  lambda_output_path    = "${path.cwd}/zip_files/lambda_function.zip"
  lambda_source_file    = "${path.cwd}/code/lambda_function.py"

}