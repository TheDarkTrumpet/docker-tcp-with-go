#!/bin/sh

cd /src
./server &
sleep 2
./client &
nginx
