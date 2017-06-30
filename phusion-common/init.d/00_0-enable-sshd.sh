#!/bin/bash

ENABLE_SSHD=${ENABLE_SSHD:-0}
echo $ENABLE_SSHD > /etc/container_environment/ENABLE_SSHD

if [ "${ENABLE_SSHD}" == "1" ]; then
    echo "Enabling service: sshd"
    rm -f /etc/service/sshd/down
fi
