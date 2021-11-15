#!/bin/bash

CURDIR="$PWD"

echo "Current Working Directory: $CURDIR"

if [[ $CURDIR == *micro\/api ]]
then
   echo "Running build!"
   mkdir artifacts
   cd ../../../server/api
   make clean
   make
   cp build/server "$CURDIR/artifacts"
   cd $CURDIR
   docker build -t thedarktrumpet/docker-tcp-with-go:micro_api .
   rm -Rf artifacts
else
  echo "You must run this script within the docker/micro/api directory!"
fi



