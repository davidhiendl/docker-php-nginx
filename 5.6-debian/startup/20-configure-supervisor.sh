#!/bin/bash

cd /etc/supervisor/

# NGINX
ENABLE_NGINX=${ENABLE_NGINX:=1}
if [ "$ENABLE_NGINX" = "1" ]
then 
	mv conf.d.disabled/nginx.conf conf.d/nginx.conf
fi

# PHP-FPM
ENABLE_PHPFPM=${ENABLE_PHPFPM:=1}
if [ "$ENABLE_PHPFPM" = "1" ]
then
	mv conf.d.disabled/php-fpm.conf conf.d/php-fpm.conf
fi

# CROND
ENABLE_CROND=${ENABLE_CROND:=0}
if [ "$ENABLE_CROND" = "1" ]
then
	mv conf.d.disabled/crond.conf conf.d/crond.conf
fi

# SSHD
ENABLE_SSHD=${ENABLE_SSHD:=0}
if [ "$ENABLE_SSHD" = "1" ]
then
	mv conf.d.disabled/sshd.conf conf.d/sshd.conf
fi
