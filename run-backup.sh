#!/bin/sh

echo 'Backup test';

# docker exec -t hc_api_db pg_dumpall -c -U hcuser > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

mkdir /tmp
cd /tmp
rm -f $AWS_S3_BUCKET_FILENAME

pg_dump -Fc -h $DB_HOST -U $DB_USER -p $DB_PORT $DB_NAME > $AWS_S3_BUCKET_FILENAME

aws s3 cp /tmp/$AWS_S3_BUCKET_FILENAME s3://$AWS_S3_BUCKET/$AWS_S3_BUCKET_PATH/$AWS_S3_BUCKET_FILENAME

