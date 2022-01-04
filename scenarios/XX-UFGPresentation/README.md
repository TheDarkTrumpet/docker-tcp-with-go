# XX-UFGPresentation

## Introduction

This is the script for the presentation for UFG over Docker Containers.  Much of what we'll cover here is in 01+ in the `scenarios` folder.

# Part 1 - Docker Pull
## Description

`docker pull` is a fundamental command, that can allow us to pull a container from a registry.  The default registry is hub.dockerhub.com, but other registries are possible.  The image name, in general, dictates how this pull will happen.

Sometimes, for very popular images, you won't have a user associated with it.  Our task, 1a, below is one such case.  If it's not a core image, then a user name is associated with it like in 1b.

## Part 1a - Steps
1. visit https://hub.dockerhub.com
2. Search for `eclipse-temurin`
3. Select the repository
4. Select `Tags`
5. Ensure 'sort by' is set to newest
6. Select the first one `17.0.1_12-jre-focal` and hit the 'copy' button on the right.
7. Run that command in docker

## Part 1b - Steps
1. visit https://hub.dockerhub.com
2. Search for `docker-tcp-with-go`
3. Click on the image name.
4. Click on tags
5. Look for `monolithic` and click the copy icon to the right of the command it gives.
6. Paste in a terminal and run it.

## Part 1c - Steps
1. Navigate your terminal to the `/image` directory within the repository.
2. run `sh get_images.sh` (Or `./get_images.sh`)

# Part 2 - Basic Docker Commands

There are a few core commands that are important to understand when working with **images**, besides pull.  To run them `docker run`, to list them `docker images`, to list running containers `docker ps`, and so on are also very important.

## Part 2a - Docker Images

1. In a terminal, run `docker images`

If you ran everything, up to this point correctly, you should see something like the following:

```text
user@qlab:~$ docker images
REPOSITORY                          TAG                    IMAGE ID       CREATED       SIZE
eclipse-temurin                     17.0.1_12-jre-focal    a5ac3e118ae4   13 days ago   295MB
thedarktrumpet/docker-tcp-with-go   micro_api              2d0e8d4456d6   7 weeks ago   80.1MB
thedarktrumpet/docker-tcp-with-go   micro_web              2b01b6680dd7   7 weeks ago   142MB
thedarktrumpet/docker-tcp-with-go   server_client_client   75933e7cf5fb   7 weeks ago   76.5MB
thedarktrumpet/docker-tcp-with-go   server_client_server   992b89973b3a   7 weeks ago   149MB
thedarktrumpet/docker-tcp-with-go   monolithic             fb6385fa752e   7 weeks ago   153MB
user@qlab:~$
```

## Part 2b - Docker Run, Ps, and Kill

1. In a terminal, run `docker ps`.  At this point, you shouldn't notice anything running.
2. Run `docker run thedarktrumpet/docker-tcp-with-go:monolithic`

You should see something like the following:

```text
user@qlab ~ » docker run thedarktrumpet/docker-tcp-with-go:monolithic                                                                                                         137 ↵
Calling setupHandlers()
Calling handleConnection() til finished
Attempting to connect to localhost:9999
!! Got connection from 127.0.0.1:55200!!
127.0.0.1:55200 => 127.0.0.1:9999: and Message! 98081
127.0.0.1:9999 <= 127.0.0.1:55200: and Message! 98081
user@qlab ~ » 
```

3. Run, in another terminal, run `docker ps`

You should see something like:

```text
user@qlab ~ » docker ps                                                                                                                                                         1 ↵
CONTAINER ID   IMAGE                                          COMMAND                  CREATED         STATUS         PORTS     NAMES
b880310ab53d   thedarktrumpet/docker-tcp-with-go:monolithic   "/docker-entrypoint.…"   6 seconds ago   Up 5 seconds   80/tcp    stupefied_stonebraker
user@qlab ~ »
```

4. Kill the container, by the container ID.  Yours will be different than mine, my command would be: `docker kill b880310ab53d` (**your hash will be different**)

You should see something like the following:

```text
user@qlab ~ » docker kill b880310ab53d
b880310ab53d
user@qlab ~ »
```

# Part 3 - Interacting with a Container - Shell

# Part 4 - Interacting with a Container - Web and Networking

# Part 5 - Mounting local directories (good for development)

# Part 7 - Docker Compose

# Part 8 - Cleanup of Images

# Part 9 - Building of Images 

# Part 10 - Design Patterns


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
