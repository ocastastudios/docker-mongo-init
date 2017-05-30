#!/bin/sh
echo 'Waiting, to give containers time to link...'
sleep 10
echo 'Creating...'
mongo -u $ADMIN_USER -p $ADMIN_PASSWORD --authenticationDatabase $AUTH_DATABASE --host $HOST $NEW_DATABASE --eval "db.createUser({ user: \"$NEW_USER\", pwd: \"$NEW_PASSWORD\", roles: [{ role: \"readWrite\", db: \"$NEW_DATABASE\" }] })"
echo 'All done.'
