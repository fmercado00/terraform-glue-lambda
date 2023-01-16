############################################################
#                    IAM Variables
############################################################
variable "role_name" {
  description = "The name of the role"
  type        = string
}

variable "log_policy_name" {
  description = "The name of the log policy"
  type        = string
}
############################################################
#                    GLUE Variables
############################################################
variable "job_name" {
  description = "The name of the job"
  type        = string
}

variable "job_type" {
  description = "The type of the job"
  type        = string
}

variable "job_timeout" {
  description = "The timeout of the job"
  type        = string
}

variable "job_number_of_workers" {
  description = "The number of workers for the job"
  type        = string
}

variable "job_python_name" {
  description = "The name of the python script for the job"
  type        = string
}

############################################################
#                    S3 BUCKETS Variables
############################################################
variable "bucket_source_name" {
  description = "The name of the source bucket"
  type        = string
}

variable "bucket_target_name" {
  description = "The name of the target bucket"
  type        = string
}

variable "s3_acl" {
  description = "Access Control List for S3 Bucket"
  type        = string
}

variable "s3_bucket_versioning" {
  description = "S3 Bucket Versioning"
  type        = string
}

#######################################################
#                   LAMBDA
####################################################### 

variable "lambda_function_name" {
  description = "The name of the lambda function"
  type        = string
}

variable "lambda_runtime" {
  description = "The runtime of the lambda function"
  type        = string
}

variable "lambda_timeout" {
  description = "The timeout of the lambda function"
  type        = string
}