#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
VOL_HOST=$DIR/volumes



## Start mysql
# MySQL settings
MYSQL_DOCKER_IMG="mysql:5.7"
MYSQL_CONTAINER_NAME="mysql"
MYSQL_ROOT_PASSWORD="password"

# Kill old dockers
mkdir -p $VOL_HOST/mysql
docker rm -f -v $MYSQL_CONTAINER_NAME
# Start new ones
docker run -d \
  --restart="always" \
  --name ${MYSQL_CONTAINER_NAME} \
  -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
  -e "TZ=Asia/Taipei" \
  -v $VOL_HOST/mysql:/var/lib/mysql \
  -p 3306:3306 \
  $MYSQL_DOCKER_IMG


## Start metabase
# See: https://github.com/metabase/metabase/blob/master/docs/operations-guide/running-metabase-on-docker.md
mkdir -p $VOL_HOST/metabase-data

echo "# Launching metabase"
docker rm -fv metabase
docker run -d -p 3000:3000 \
    -v $VOL_HOST/metabase-data:/metabase-data \
    -e "MB_DB_FILE=/metabase-data/metabase.db" \
    -e "JAVA_TIMEZONE=Asia/Taipei" \
    --name metabase metabase/metabase


echo "# Should be ok now, please open:"
echo "http://localhost:3000  (Default login = admin/admin) "

docker logs -f metabase
