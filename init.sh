#!/bin/bash
#
set -euo pipefail

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_PASSWORD' 'example'
# (will allow for "$XYZ_PASSWORD_FILE" to fill in the value of
#  "$XYZ_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
        export "$var"="$val"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
        export "$var"="$val"
	fi
	unset "$fileVar"
}


envs=(
	ADMIN_USER
    ADMIN_PASSWORD
	AUTH_DATABASE
	NEW_DATABASE
	NEW_USER
	NEW_PASSWORD
    HOST
)

for e in "${envs[@]}"; do
	file_env "$e"
done

: ${AUTH_DATABASE:="admin"}

if [ -z ${ADMIN_USER+x} ]; then echo "ADMIN_USER is unset"; exit 1; fi
if [ -z ${ADMIN_PASSWORD+x} ]; then echo "ADMIN_PASSWORD is unset"; exit 1; fi
if [ -z ${NEW_DATABASE+x} ]; then echo "NEW_DATABASE is unset"; exit 1; fi
if [ -z ${NEW_USER+x} ]; then echo "NEW_USER is unset"; exit 1; fi
if [ -z ${NEW_PASSWORD+x} ]; then echo "NEW_PASSWORD is unset"; exit 1; fi
if [ -z ${HOST+x} ]; then echo "HOST is unset"; exit 1; fi

echo 'Waiting, to give containers time to link...'
sleep 10
echo 'Creating...'
echo $AUTH_DATABASE
mongo -u $ADMIN_USER -p $ADMIN_PASSWORD --authenticationDatabase $AUTH_DATABASE --host $HOST --eval "db.createUser({ user: \"$NEW_USER\", pwd: \"$NEW_PASSWORD\", roles: [{ role: \"readWrite\", db: \"$NEW_DATABASE\" }] })"
echo 'All done.'
