#!/bin/bash
# Replace config placeholders with environment variables

NGINX_WORKER_PROCESSES=${NGINX_WORKER_PROCESSES:=8}

sed -i -e "s/__NGINX_WORKER_PROCESSES__/${NGINX_WORKER_PROCESSES}/" /etc/nginx/nginx.conf
