
# Note: Check if the docker image is up to date
# https://hub.docker.com/r/doccano/doccano/builds

#VOLUME=$PWD/volume
#mkdir -p $VOLUME

VOLUME=doccano-data
echo "VOLUME=$VOLUME"

docker rm -f doccano
docker run -d --name doccano \
  -e "ADMIN_USERNAME=admin" \
  -e "ADMIN_EMAIL=admin@example.com" \
  -e "ADMIN_PASSWORD=password" \
  -v $VOLUME:/data \
  -p 8000:8000 doccano/doccano

