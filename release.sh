set -ex

# From Travis Reeder
# https://medium.com/travis-on-docker/how-to-version-your-docker-images-1d5c577ebf54

# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=bomeara
# image name
IMAGE=datelife
# ensure we're up to date
git pull
# bump version
docker run --rm -v "$PWD":/app treeder/bump patch
version=`cat VERSION`
echo "version: $version"
# run build
./build.sh
# tag it
git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push
git push --tags
docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version
# push it
docker push $USERNAME/$IMAGE:latest
docker push $USERNAME/$IMAGE:$version
