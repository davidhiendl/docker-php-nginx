#!/bin/bash

chown www-data:www-data -R /www/.ssh
chmod 700 /www/.ssh
chmod go-w /www /www/.ssh
chmod 600 /www/.ssh/authorized_keys