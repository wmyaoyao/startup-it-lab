#!/bin/bash
# For gitlab default config, see:
# https://github.com/sameersbn/docker-gitlab

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
VOL_HOST=$DIR/volumes
CERT_DIR=$DIR/certs

#------------------------------------------------------------------------------
# FIXME: update these settings to fit your environment
GITLAB_HOST=gitlab.wmayoyao.pw
# Note: Generate the following keys with pwgen
# e.g., pwgen -Bsv1 64
GITLAB_KEY=foobarfoobar-key1
GITLAB_DB_KEY=aaabbbcccdddeeefff-key2
GITLAB_OTP_KEY=xxxyyyzzzaaabbbccc-key3
#------------------------------------------------------------------------------

echo "# Step 1. Launch a postgresql container"
docker rm -f gitlab-postgresql
docker run -d --restart always \
    --name gitlab-postgresql \
    --env 'DB_NAME=gitlabhq_production' \
    --env 'DB_USER=gitlab' --env 'DB_PASS=password' \
    --env 'DB_EXTENSION=pg_trgm' \
    --volume $VOL_HOST/postgresql:/var/lib/postgresql \
    sameersbn/postgresql:9.4-21

echo "# Step 2. Launch a redis container"
docker rm -f gitlab-redis
docker run -d --restart always \
    --name gitlab-redis \
    --volume $VOL_HOST/redis:/var/lib/redis \
    sameersbn/redis:latest

echo "# Step 3. Launch the gitlab container"

docker rm -f gitlab
docker run -d --restart always \
    --name gitlab \
    --link gitlab-postgresql:postgresql --link gitlab-redis:redisio \
    --publish 10022:22 --publish 80:80 --publish 443:443 \
    --env GITLAB_SSH_PORT='10022' --env GITLAB_PORT='443' \
    --env GITLAB_HTTPS='true' --env SSL_SELF_SIGNED='true' \
    --volume $CERT_DIR:/home/git/data/certs \
    --env GITLAB_SECRETS_SECRET_KEY_BASE=$GITLAB_KEY \
    --env GITLAB_SECRETS_DB_KEY_BASE=$GITLAB_DB_KEY \
    --env GITLAB_SECRETS_OTP_KEY_BASE=$GITLAB_OTP_KEY \
    --env GITLAB_HOST=$GITLAB_HOST \
    --volume $VOL_HOST/gitlab:/home/git/data \
    --volume $VOL_HOST/log:/var/log/gitlab \
    sameersbn/gitlab:8.11.7

echo "Wait a few minutes (if it's the 1st run)"
echo "Goto https://$GITLAB_HOST"
