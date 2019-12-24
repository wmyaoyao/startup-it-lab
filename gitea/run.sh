#!/bin/bash

VOLUME=$PWD/volume
mkdir -p $VOLUME
echo "VOLUME=$VOLUME"

docker run -d --name=gitea -p 10022:22 -p 10080:3000 \
 -v $VOLUME:/data gitea/gitea:1.10.1

