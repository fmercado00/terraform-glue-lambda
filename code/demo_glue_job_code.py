# -*- coding: utf-8 -*-
"""
@author: steve.george
@additional: Francisco Mercado
"""
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.sql.functions import *
from pyspark.sql.types import *
from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()


def remove_duplicate(df):
    '''Remove duplicate rows from dataframe'''
    return df.dropDuplicates()



def change_columnname(df):
    '''Change column name'''
    columns = ["ClassA","ClassB","ClassC","ClassD"]
    return df.toDF(*columns)


def mapping(df):
    '''Change column type to int'''
    df3 = df.withColumn("ClassA",df.ClassA.cast('int'))
    df3 = df.withColumn("ClassC",df.ClassC.cast('int'))
    return df3


def impute(df):
    '''Impute NA with value 0'''
    return df.na.fill(value=0)


def main():
    '''Main function'''
    args = getResolvedOptions(sys.argv, ["file","bucket"])
    file_name=args['file']
    bucket_name=args['bucket']
    # file_name="sample1.csv"
    # bucket_name="demo-glue-lambda-source0406"
    print("Bucket Name" , bucket_name)
    print("File Name" , file_name)
    input_file_path="s3://{}/{}".format(bucket_name,file_name)
    print("Input File Path : ",input_file_path);
    
    df = spark.read.option("inferSchema", False).option("header", "true").csv(input_file_path)
    df1 = remove_duplicate(df)
    df2 = change_columnname(df1)
    df3 = mapping(df2)
    df4 = impute(df3)
    df4.coalesce(1).write.format("csv").mode('overwrite').option("header", "true").save("s3://demo-glue-lambda-target0406/{}".format(file_name.split('.')[0]))


main()