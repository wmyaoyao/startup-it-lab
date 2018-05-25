#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
VOL_HOST=$DIR/volumes

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
