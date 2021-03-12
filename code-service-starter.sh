#!/bin/sh

echo "Starting the code-server"
cd /code-server/projects
su -c "code-server --user-data-dir=/data --install-extension Gruntfuggly.todo-tree"
su -c "code-server --user-data-dir=/data --install-extension mhutchie.git-graph"
su -c "code-server --user-data-dir=/data --install-extension ms-python.python"
su -c "code-server --user-data-dir=/data --install-extension ms-toolsai.jupyter"
su -c "code-server --user-data-dir=/data --install-extension ugross.vscode-react-snippets"
chown -R code /data
su -c "code-server --auth=none --disable-telemetry --disable-update-check --bind-addr=0.0.0.0:8081 --user-data-dir=/data --verbose" code

