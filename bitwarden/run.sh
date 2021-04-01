#!/bin/bash

# docker pull bitwardenrs/server:latest

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
VOLUME=$DIR/bw-data
echo "VOLUME=$VOLUME"

docker run -d --name bitwarden -v $VOLUME:/data/ -p 80:80 bitwardenrs/server:latest
