FROM postgres:12-alpine

# setup pip, use pip to install awscli
RUN apk add --no-cache --update py-pip
RUN pip install awscli

# copy required shell scripts, and the new crontab text
COPY run-backup.sh ./
COPY entry.sh ./
COPY cron-backup.txt ./

# make shell scripts executable
RUN chmod +x *.sh

# start by running entry.sh
ENTRYPOINT [ "./entry.sh" ]
