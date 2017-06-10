#!/bin/bash

STARTUP_DIR="/etc/startup.d"
SWARM_STARTUP_DIR="/run/secrets"
SUPERVISOR_CONFIG="/etc/supervisor/supervisord.conf"

# run startup scripts
if [ -d "${STARTUP_DIR}" ]; then
	
	cd "${STARTUP_DIR}"
	echo "entrypoint: processing scripts in ${STARTUP_DIR}"
	
	for SCRIPT in ${STARTUP_DIR}/*.sh
	do
		if [ -f $SCRIPT -a -x $SCRIPT ]; then
			echo "entrypoint: executing ${SCRIPT}"
			. "${SCRIPT}"
		fi
	done
	
	echo "entrypoint: finished processing scripts in ${STARTUP_DIR}"
fi


# run docker swarm dynamically supplied startup scripts
if [ -d "${SWARM_STARTUP_DIR}" ]; then
	
	cd "${SWARM_STARTUP_DIR}"
	echo "entrypoint: processing scripts in ${SWARM_STARTUP_DIR}"
	
	for SCRIPT in ${SWARM_STARTUP_DIR}/startup-*.sh
	do
		if [ -f $SCRIPT -a -x $SCRIPT ]; then
			echo "entrypoint: executing ${SCRIPT}"
			. "${SCRIPT}"
		fi
	done
	
	echo "entrypoint: finished processing scripts in ${SWARM_STARTUP_DIR}"
fi


# run supervisor
echo "starting supervisord: with ${SUPERVISOR_CONFIG}"
cd /
/usr/bin/supervisord -n -c $SUPERVISOR_CONFIG
