#!/bin/ash
# echo Hit enter or stop container

# trap "echo TRAPed signal" HUP INT QUIT TERM

# load cron-backup script to crontab
cat /cron-backup.txt >> /etc/crontabs/root

# force crontab update
touch /etc/crontabs/cron.updated

# this will hold the session open
crond -f -l 2

#cleanup
echo Exiting