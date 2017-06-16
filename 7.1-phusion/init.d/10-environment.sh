#!/bin/bash
set -e


# container debug
CONTAINER_DEBUG=${CONTAINER_DEBUG:-0}
echo $CONTAINER_DEBUG > /etc/container_environment/CONTAINER_DEBUG
