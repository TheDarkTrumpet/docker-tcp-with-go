#!/bin/bash

CURDIR="$PWD"

echo "Current Working Directory: $CURDIR"

if [[ $CURDIR == *micro\/web ]]
then
   echo "Running build!"
   mkdir artifacts
   cd ../../../server/frontend
   npm run build
   cp -R dist "$CURDIR/artifacts"
   cd $CURDIR/artifacts/dist
   find . -type f -exec sed -i 's/http:\/\/localhost:8081\/api/\/api/g' {} \;
   cd $CURDIR
   docker build -t thedarktrumpet/docker-tcp-with-go:micro_web .
   rm -Rf artifacts
else
  echo "You must run this script within the docker/micro/web directory!"
fi



