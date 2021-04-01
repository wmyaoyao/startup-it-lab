#!/bin/bash

# docker pull bitwardenrs/server:latest

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
VOLUME=$DIR/bw-data
echo "VOLUME=$VOLUME"

# You may want to change this password...
ADMIN_PAGE_PASS=bwadmin

docker rm -fv bitwarden
docker run -d --name bitwarden \
	-v $VOLUME:/data/ \
	-p 8090:80 \
	-e ADMIN_TOKEN=$ADMIN_PAGE_PASS \
       bitwardenrs/server:latest

echo ""
echo "# NOTE: "
echo "# Admin page: http://<server IP>:8090/admin"
echo "# pass = $ADMIN_PAGE_PASS"
