#!/bin/bash

# fail on error
set -e

# install required packages 
# - add mcrypt explicly as it is required during runtime and would get cleaned up by apt-get autoremove
# - most packages (*-dev, make, g++, autconf) get cleaned up after build
apt-get update
apt-get install -y --no-install-recommends \
	bash \
	supervisor \
	nginx \
	autoconf \
	g++ \
	make \
	openssh-server \
	cron


# install sshd
mkdir -p /var/run/sshd
# remove auto-gen keys
rm -f /etc/ssh/ssh_host_*key*
# add key directories for users
mkdir -p /etc/ssh/authorized_keys/


# redirect nginx output to console
ln -sf /dev/stdout /var/log/nginx/access.log
ln -sf /dev/stderr /var/log/nginx/error.log


# install supported php extensions
docker-php-ext-install opcache


# cd to web root and cleanup default files and folders
mkdir -p /www/htdocs


# prepare sftp for www-data
usermod www-data --shell /bin/bash
usermod www-data --home /www
mkdir -p /www/.ssh
touch /www/.ssh/authorized_keys

chown www-data:www-data -R /www/.ssh
chmod 700 /www/.ssh
chmod go-w /www /www/.ssh
chmod 600 /www/.ssh/authorized_keys


# clean up
docker-php-source delete
apt-get remove -y \
	autoconf \
	g++ \
	make
apt-get -y autoremove
apt-get clean
rm -rf /var/lib/apt/lists/*

# update permissions
echo "Updating permissions ..."

# setup permissions on web-root
chown root:www-data /www/
chmod 550 /www/

cd /www

# setup ownership
chown -R www-data:www-data /www/