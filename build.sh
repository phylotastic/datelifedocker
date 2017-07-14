set -ex

# From Travis Reeder:
# https://medium.com/travis-on-docker/how-to-version-your-docker-images-1d5c577ebf54

# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=bomeara
# image name
IMAGE=datelife
docker build --no-cache -t $USERNAME/$IMAGE:latest .
