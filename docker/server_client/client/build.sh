#!/bin/bash

CURDIR="$PWD"

echo "Current Working Directory: $CURDIR"

if [[ $CURDIR == *server_client\/server ]]
then
   echo "Running build!"
   mkdir artifacts
   cd ../../../client
   make clean
   make
   cd $CURDIR
   docker build -t thedarktrumpet/docker-tcp-with-go:server_client_client .
   rm -Rf artifacts
else
  echo "You must run this script within the docker/server_client/server directory!"
fi



