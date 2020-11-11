FROM postgres:12-alpine

RUN apk add --no-cache --update py-pip
RUN pip install awscli

COPY run-backup.sh ./
COPY entry.sh ./
COPY cron-backup.txt ./

RUN chmod +x *.sh

ENTRYPOINT [ "./entry.sh" ]
