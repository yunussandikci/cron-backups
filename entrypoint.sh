#!/bin/sh

set -e
echo "Cron backups started"
echo "$CRON /backup.sh" | crontab - && crond -f -L /dev/stdout
