#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
VOL_HOST=$DIR/volumes

# See: https://www.openproject.org/docker/
mkdir -p $VOL_HOST/{pgdata,logs,static}

echo "# Launching openproject"
docker rm -fv openproject
docker run -d -p 8080:80 --name openproject -e SECRET_KEY_BASE=secret \
  -v $VOL_HOST/pgdata:/var/lib/postgresql/9.4/main \
  -v $VOL_HOST/logs:/var/log/supervisor \
  -v $VOL_HOST/static:/var/db/openproject \
  openproject/community:7

echo "# Should be ok now, please open:"
echo "http://localhost:8080  (Default login = admin/admin) "
