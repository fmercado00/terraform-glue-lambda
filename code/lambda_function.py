import json 
import boto3

def lambda_handler(event, context):
   glue = boto3.client("glue")
   file_name = event['Records'][0]['s3']['object']['key']
   bucket_name = event['Records'][0]['s3']['bucket']['name']
   print("File Name : ", file_name)
   print("Bucket Name : ",bucket_name)
   response = glue.start_job_run(
               JobName = "demo-glue-lambda-job",
               Arguments = {
                  "--file":   file_name,
                  "--bucket": bucket_name
                  }
               )
   print("Lambda invoke")