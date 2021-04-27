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
artifact_url="https://www.dropbox.com/s/q0qc2t7d9alo9fk/data-$GEOSERVER_VERSION.zip"
echo "Downloading: $artifact_url"
curl  -k -L -O "$artifact_url" && unzip -x -d ${TEMP_DOWNLOADED} data-$GEOSERVER_VERSION.zip
echo "GeoServer Data Directory download has been completed"
