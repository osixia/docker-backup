# Use osixia/light-baseimage
# sources: https://github.com/osixia/docker-light-baseimage
FROM osixia/light-baseimage:1.1.1
MAINTAINER Bertrand Gouny <bertrand.gouny@osixia.net>

# Install Backup Manager, GNUPG for encryption and cron from baseimage
# sources: https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/add-service-available
#          https://github.com/osixia/docker-light-baseimage/blob/stable/image/service-available/:cron/download.sh
RUN apt-get -y update \
		&& /container/tool/add-service-available :cron \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add service directory to /container/service
ADD service /container/service

# Use baseimage install-service script
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/install-service
RUN /container/tool/install-service

# Add default env variables
ADD environment /container/environment/99-default

# Set backup data in a data volume
# Must match env var BM_REPOSITORY_ROOT in backup-manager.conf
VOLUME ["/data/backup"]
