#!/bin/sh

echo "Starting the code-server"
cd /code-server/projects
su -c "code-server --auth=none --disable-telemetry --disable-update-check --bind-addr=0.0.0.0:8081 --user-data-dir=/data --verbose" code

