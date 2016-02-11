#!/bin/bash

error() {
  echo ">>>>>> Failed to build <<<<<<<<<"
  echo ""
  exit 1
}
trap error ERR

if [ -z "$GO_PIPELINE_COUNTER" ]; then
    export GO_PIPELINE_COUNTER=0
fi

if [ -z "$GO_STAGE_COUNTER" ]; then
    export GO_STAGE_COUNTER=0
fi

version=`cat ci-build/version.txt`

echo
echo ===========================================================
echo building Weather-Lookup-Service-API, VERSION = $version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER
echo ===========================================================
echo

rm -Rf ./src/AssemblyVersion.cs

cat  > ./src/AssemblyVersion.cs << EOL
using System;
using System.Reflection;

[assembly: AssemblyVersion("$version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER")]
[assembly: AssemblyFileVersion("$version.$GO_PIPELINE_COUNTER.$GO_STAGE_COUNTER")]
EOL

CURDIR=`dirname $0`
pushd $CURDIR >/dev/null
ABS_CURDIR=`pwd`
popd >/dev/null

ABS_CURDIR=`pwd`

docker run --rm \
  -v "$ABS_CURDIR:/build" \
  --workdir /build \
  mono:4.2.1 \
  xbuild /p:Configuration=Release /p:RestorePackages=true
