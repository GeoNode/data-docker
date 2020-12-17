#!/usr/bin/env sh

# Wait for version to come up before downloading it
# args  $1 - version
# args  $2 - temp directory

echo "GeoServer Data Dir version is $1"
echo "-----------------------------------------------------------------------------------------------"
echo "Archive temporary directory is $2"

GEOSERVER_VERSION=$1
TEMP_DOWNLOADED=$2 

echo "GeoServer Data Directory is going to be downloaded"
# for debugging
echo "curl -k -L -O https://www.dropbox.com/s/sebw3h90mtvnzwe/data-${GEOSERVER_VERSION}.zip"
curl -k -L -O https://www.dropbox.com/s/sebw3h90mtvnzwe/data-$GEOSERVER_VERSION.zip?dl=1 && \
unzip -x -d ${TEMP_DOWNLOADED} data-$GEOSERVER_VERSION.zip
echo "GeoServer Data Directory download has been completed"
