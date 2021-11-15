#!/bin/bash

CURDIR="$PWD"

echo "Current Working Directory: $CURDIR"

if [[ $CURDIR == *micro\/client ]]
then
   echo "Running build!"
   mkdir artifacts
   cd ../../../client
   make clean
   make
   cp build/client "$CURDIR/artifacts"
   cd $CURDIR
   docker build -t thedarktrumpet/docker-tcp-with-go:micro_client .
   rm -Rf artifacts
else
  echo "You must run this script within the docker/micro/client directory!"
fi



