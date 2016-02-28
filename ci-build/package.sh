#!/bin/bash

error() {
  echo ">>>>>> Failed to package <<<<<<<<<"
  echo ""
  exit 1
}
trap error ERR

version=`cat ../../ci-build/version.txt`

echo
echo ===========================================================
echo building docker image , $SERVICE_NAME:$version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER
echo ===========================================================
echo

IMAGE_TAG=$SERVICE_NAME:$version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER

docker build -t $IMAGE_TAG .

echo
echo ===========================================================
echo built docker image , TAG = $IMAGE_TAG
echo ===========================================================
echo
