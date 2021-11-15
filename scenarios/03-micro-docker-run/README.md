# 03-micro-docker-run

## Introduction

This tutorial will help in building 3 images.  The api image will contain the go server (API endpoint and TCP server), 
the web image will contain the nginx/vue application, and the client image will contain the go client.

It's important to run each part entirely, including the cleanup, between each activity.

## Steps to Build

1. cd to `docker-tcp-with-go/docker/micro`
2. In each of the folders, api, client and web, run the following:
   - `./build.sh`

## If Unable to Build

If you're unable to build the project for whatever reason, you can find the code at:

https://hub.docker.com/r/thedarktrumpet/docker-tcp-with-go

Obtain the images as follows:
* `docker pull thedarktrumpet/docker-tcp-with-go:micro_api`
* `docker pull thedarktrumpet/docker-tcp-with-go:micro_web`
* `docker pull thedarktrumpet/docker-tcp-with-go:micro_client`

# Part 1 - Running link with all of these

## Steps to Run
1. Run the api container, with the following command:

```shell
docker run -d --rm --name api thedarktrumpet/docker-tcp-with-go:micro_api
```

2. Run the web container, with the following command:

```shell
docker run -d --rm -p 11111:80 --link api --name web thedarktrumpet/docker-tcp-with-go:micro_web
```

3. Run a client container, with the following command:

```shell
docker run -d --link api --rm --name client2 thedarktrumpet/docker-tcp-with-go:micro_client
```

4. Open a web browser and visit http://localhost:11111

## Steps to Clean Up

1. Type `docker kill web`
2. Type `Docker kill api`
3. Type `docker kill client`

## Explanations

There's nothing specifically new here that we haven't seen already, but the point of all this is to illustrate a point.

The above steps when running the setup have to be done in order.  At least, some order.  If you spawn the client without
the server, it fails (we saw that happen in 02 when link was omitted).  The web component will fail at finding the api
endpoint as well.

Around this time, it's good to start looking at better solutions.  We'll show that next.
