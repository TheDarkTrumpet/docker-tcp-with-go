#!/bin/sh

cd /src
nohup ./server &
sleep 2
nohup ./client localhost 9999 &
nginx
