#!/bin/sh

cd /src
nohup ./server &
sleep 2
nginx
