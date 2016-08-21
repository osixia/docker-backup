#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

# install image tools
ln -sf ${CONTAINER_SERVICE_DIR}/backup/assets/tool/* /sbin/

# add cron jobs
ln -sf ${CONTAINER_SERVICE_DIR}/backup/assets/cronjobs /etc/cron.d/backup
chmod 600 ${CONTAINER_SERVICE_DIR}/backup/assets/cronjobs

FIRST_START_DONE="${CONTAINER_STATE_DIR}/docker-backup-backup-first-start-done"
# container first start
if [ ! -e "$FIRST_START_DONE" ]; then

  # adapt cronjobs file
  sed -i "s|{{ BACKUP_CRON_EXP }}|${BACKUP_CRON_EXP}|g" ${CONTAINER_SERVICE_DIR}/backup/assets/cronjobs

  touch $FIRST_START_DONE
fi

exit 0
