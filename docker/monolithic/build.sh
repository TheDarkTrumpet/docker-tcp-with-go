#!/bin/bash

CURDIR="$PWD"

echo "Current Working Directory: $CURDIR"

if [[ $CURDIR == *monolithic ]]
then
   echo "Running build!"
   mkdir artifacts
   cd ../../client
   make clean
   make
   cp build/client "$CURDIR/artifacts"
   cd ../server/api
   make clean
   make
   cp build/server "$CURDIR/artifacts"
   cd ../frontend/
   npm run build
   cp -R dist "$CURDIR/artifacts"
   cd $CURDIR/artifacts/dist
   find . -type f -exec sed -i 's/http:\/\/localhost:8081\/api/\/api/g' {} \;
   cd $CURDIR
   docker build -t thedarktrumpet/docker-tcp-with-go:monolithic .
   rm -Rf artifacts
else
  echo "You must run this script within the docker/monolithic directory!"
fi



