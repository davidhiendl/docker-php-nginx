#!/bin/bash

ENABLE_CRON=${ENABLE_CRON:-0}
echo $ENABLE_CRON > /etc/container_environment/ENABLE_CROND

if [ "${ENABLE_CRON}" != "1" ]; then
    echo "Disabling service: cron"
    touch /etc/service/cron/down
fi
