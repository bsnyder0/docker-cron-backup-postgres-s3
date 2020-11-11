#!/bin/sh

# check that all required args are set
if [ -z "$DB_HOST" ]
then
    echo "Required ENV: DB_HOST";
    error=1;
fi

if [ -z "$DB_USER" ]
then
    echo "Required ENV: DB_USER";
    error=1;
fi

if [ -z "$PGPASSWORD" ]
then
    echo "Required ENV: PGPASSWORD";
    error=1;
fi

if [ -z "$DB_PORT" ]
then
    echo "Required ENV: DB_PORT";
    error=1;
fi

if [ -z "$DB_NAME" ]
then
    echo "Required ENV: DB_NAME";
    error=1;
fi

if [ -z "$AWS_S3_BUCKET" ]
then
    echo "Required ENV: AWS_S3_BUCKET";
    error=1;
fi

if [ -z "$AWS_S3_BUCKET_PATH" ]
then
    echo "Required ENV: AWS_S3_BUCKET_PATH";
    error=1;
fi

if [ -z "$AWS_S3_BUCKET_FILENAME" ]
then
    echo "Required ENV: AWS_S3_BUCKET_FILENAME";
    error=1;
fi

if [ "$error" ]
then
    echo Error found, quitting.
    exit 1;
fi

# load cron-backup script to crontab
cat /cron-backup.txt >> /etc/crontabs/root

# force crontab update
touch /etc/crontabs/cron.updated

# this will hold the session open; Forground, logging level 2
crond -f -l 2

#cleanup
echo Crond stopped, exiting