FROM		phusion/baseimage:0.9.22
MAINTAINER	David Hiendl <david.hiendl@dhswt.de>

ARG		PHP_VERSION

ENV		WEB_HOME	/www
ENV		WEB_ROOT	/www/htdocs

EXPOSE	80
VOLUME	/www/htdocs
WORKDIR	/www
SHELL	["/bin/bash", "-c"]
CMD		/sbin/my_init

RUN		DEBIAN_FRONTEND=noninteractive \

# source helper functions
&&		bash <(curl -s https://raw.githubusercontent.com/davidhiendl/docker-helpers/master/install-bash.sh) \
&&		source /usr/local/docker-helpers.sh \

# install packaged dependencies
&&		add-apt-repository ppa:ondrej/php \
&&		apt-get update \
&&		apt-get install -y \
			nginx \
			gettext-base \
			wget \
			"php${PHP_VERSION}-fpm" \
			"php${PHP_VERSION}-opcache" \
			
# clean up cache
&&		apt-get clean \
&&		rm -rf \
			/var/lib/apt/lists/* \
			/tmp/* \
			/var/tmp/* \

# create clean web root dir
&&		mkdir -p /www/htdocs \
&&		chown www-data:www-data -R /www \

# remove default nginx site
&&		rm /etc/nginx/sites-enabled/* \

# configure php-fpm
&&		cd "/etc/php/${PHP_VERSION}/fpm" \
&&		mv php-fpm.conf php-fpm.conf.bak \

# keep only active directives
&&		cat pool.d/www.conf \
			| grep -v "^;" \
			| grep -v "^$" \
			> pool.d/50-www.conf.bak \
&&		rm pool.d/www.conf

# install services, scripts, config
ADD		services	/etc/service
ADD		init.d		/etc/my_init.d
ADD		php-fpm		"/etc/php/${PHP_VERSION}/fpm/"
ADD		nginx		/etc/nginx/

# fill in php version
RUN		source /usr/local/docker-helpers.sh \
&&		envsubst_inplace '${PHP_VERSION}' /etc/php/${PHP_VERSION}/fpm/php-fpm.conf \
&&		envsubst_inplace '${PHP_VERSION}' /etc/service/php-fpm/run \

# update permissions
&&		chmod 555 \
		/etc/my_init.d/* \
		/etc/service/nginx/* \
		/etc/service/php-fpm/*
