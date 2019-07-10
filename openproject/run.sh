#!/bin/bash

# Reference: 
# https://www.openproject.org/docker/
# https://github.com/opf/openproject/blob/dev/docs/configuration/configuration.md
PORT=8080
SECRET_KEY=secret
SMTP_PASS="<apply at sendgrit>"
SMTP_DOMAIN=example.org



DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
VOL_HOST=$DIR/volumes

# See: https://www.openproject.org/docker/
mkdir -p $VOL_HOST/{pgdata,static}

echo "# Launching openproject"
docker rm -fv openproject
docker run -d -p $PORT:80 --name openproject \
  -e SECRET_KEY_BASE=$SECRET_KEY \
  -e EMAIL_DELIVERY_METHOD=smtp \
  -e SMTP_ADDRESS=smtp.sendgrid.net \
  -e SMTP_PORT=587 \
  -e SMTP_DOMAIN=$SMTP_DOMAIN \
  -e SMTP_AUTHENTICATION=login \
  -e SMTP_ENABLE_STARTTLS_AUTO=true \
  -e SMTP_USER_NAME="apikey" \
  -e SMTP_PASSWORD=$SMTP_PASS \
  -v $VOL_HOST/pgdata:/var/openproject/pgdata \
  -v $VOL_HOST/static:/var/openproject/assets \
  openproject/community:9

# FIXME: delete logs volume??
#  -v $VOL_HOST/logs:/var/log/supervisor \

echo "# Should be ok now, please open:"
echo "http://localhost:8080  (Default login = admin/admin) "
