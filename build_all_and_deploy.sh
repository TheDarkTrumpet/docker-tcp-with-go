#!/bin/sh

# NOTE: This is not intended to be run by most, it's an ease of use for me.

CURDIR="$PWD"

cd $CURDIR/docker/micro/api
./build.sh

cd $CURDIR/docker/micro/client
./build.sh

cd $CURDIR/docker/micro/web
./build.sh

cd $CURDIR/docker/monolithic
./build.sh

cd $CURDIR/server_client/client
./build.sh

cd $CURDIR/server_client/server
./build.sh
