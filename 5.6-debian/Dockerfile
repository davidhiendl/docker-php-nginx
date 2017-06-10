FROM php:5.6-fpm

ADD build.sh /


# build
RUN chmod +x /build.sh \
&&	/build.sh \
&&	rm /build.sh


# expose http and sshd
EXPOSE 80 22


# use custom entry point which executes startup scripts
WORKDIR /
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]


# copy configuration files
ADD ssh 				/etc/ssh
ADD startup				/etc/startup.d/
ADD nginx				/etc/nginx/
ADD php					/usr/local/etc/php/conf.d/
ADD php-fpm				/usr/local/etc/php-fpm.d/
ADD supervisor			/etc/supervisor