#######################################################
#                   IAM
####################################################### 
role_name             = "glue_lambda_role"
log_policy_name       = "policies"
#######################################################
#                   GLUE JOB                         
####################################################### 
job_name              = "demo-glue-lambda-job"
job_type              = "G.1X"
job_timeout           = "1440"
job_number_of_workers = "2"
job_python_name       = "demo_glue_job_code.py"
#######################################################
#                       S3                      
####################################################### 
bucket_source_name   = "demo-glue-lambda-source0406"
bucket_target_name   = "demo-glue-lambda-target0406"
s3_acl               = "private"
s3_bucket_versioning = "Enabled"
#######################################################
#                    Lambda                      
####################################################### 
lambda_function_name = "demo-glue-lambda"
lambda_runtime       = "python3.9"
lambda_timeout       = "30"