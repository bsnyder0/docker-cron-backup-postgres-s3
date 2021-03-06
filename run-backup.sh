#!/bin/sh

mkdir /tmp
cd /tmp
rm -f $AWS_S3_BUCKET_FILENAME

pg_dump -Fc -h $DB_HOST -U $DB_USER -p $DB_PORT $DB_NAME | aws s3 cp - s3://$AWS_S3_BUCKET/$AWS_S3_BUCKET_PATH/$AWS_S3_BUCKET_FILENAME
