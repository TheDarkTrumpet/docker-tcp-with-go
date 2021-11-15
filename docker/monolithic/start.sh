#!/bin/sh

cd /src
./server &
sleep 2
./client localhost 8081 &
nginx
