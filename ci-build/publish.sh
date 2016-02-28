
#!/bin/bash

error() {
  echo ">>>>>> Failed to publish <<<<<<<<<"
  echo ""
  exit 1
}
trap error ERR

version=`cat ./ci-build/version.txt`


IMAGE_TAG=$SERVICE_NAME:$version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER

REPO_TAG=$DOCKER_REGISTRY/$IMAGE_TAG

echo
echo ">>>>>>>>>>>>>>>Publishing image as $REPO_TAG to registry <<<<<<<<<<<<<<<<<<<<" 
echo

docker tag $IMAGE_TAG $REPO_TAG
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD -e " " https://$DOCKER_REGISTRY
docker push $REPO_TAG


echo "$version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER" > service_version.txt


echo
echo ===========================================================
echo publishing , $SERVICE_NAME:$version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER
echo ===========================================================
echo

echo ========
echo
echo ">>>>>>>>>>>>>>> Tagging GIT repo as v$version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER <<<<<<<<<<<<<<<<<<<<" 
echo
$(git tag -a v$version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER -m "Tagged by CI publish stage")
git push origin --tags


echo
echo ===========================================================
echo Tagged docker image TAG = $IMAGE_TAG
echo Published docker image , REPO TAG = $REPO_TAG
echo Pushed to https://$DOCKER_REGISTRY
echo Git repo tagged as v$version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER
echo ===========================================================
echo
