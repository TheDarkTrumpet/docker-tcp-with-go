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

## Description
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

# Part 3 - Interacting with a Container - Shell and Logs
## Description

Sometimes it's useful to physically interact with a running container to aid in debugging, but also to grab config files and the like from it (say with nginx for modification).  Viewing the logs, especially when dealing with daemon mode, is very useful.

## Part 3a - Launching monolithic as daemon & view logs

1. Run the following command:

```bash
docker run -d -p 11111:80 --rm --name monolithic thedarktrumpet/docker-tcp-with-go:monolithic
```

2. Then run `docker ps` to see what's running.

You should see the following, from the above two commands:

```text
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
user@qlab:~$ docker run -d -p 11111:80 --rm --name monolithic thedarktrumpet/docker-tcp-with-go:monolithic
629b712ef7073f8b2e7be1366127f96725bb2335814d27e3cd819c8ab4e761b7
user@qlab:~$ docker ps
CONTAINER ID   IMAGE                                          COMMAND                  CREATED          STATUS          PORTS                                     NAMES
629b712ef707   thedarktrumpet/docker-tcp-with-go:monolithic   "/docker-entrypoint.…"   16 seconds ago   Up 11 seconds   0.0.0.0:11111->80/tcp, :::11111->80/tcp   monolithic
user@qlab:~$
```

3. Run `docker logs monolithic`, and you should see something like the following:

```text
user@qlab:~$ docker logs monolithic
Calling setupHandlers()
Calling handleConnection() til finished
Attempting to connect to localhost:9999
!! Got connection from 127.0.0.1:58750!!
127.0.0.1:58750 => 127.0.0.1:9999: and Message! 98081
127.0.0.1:9999 <= 127.0.0.1:58750: and Message! 98081
127.0.0.1:9999 => 127.0.0.1:58750: and Message! 24593
127.0.0.1:58750 <= 127.0.0.1:9999: and Message! 24593
127.0.0.1:58750 => 127.0.0.1:9999: and Message! 31847
127.0.0.1:9999 <= 127.0.0.1:58750: and Message! 31847
...
```

Keep the image up til told to close it (We'll use it up through the end of part 4).

## Part 3a - Shell 'login'

1. Run `docker exec -it monolithic /bin/bash` and you should get the following:

```text
user@qlab:~$ docker exec -it monolithic /bin/bash
root@629b712ef707:/#
```

From here, you can play around a bit.  If you try running something like top, ps, etc. you'll notice that little is available.  Furthermore, if you cd into the `/src` directory, you can see the scripts/programs we're executing.

Often times this is is a useful command to do extra debugging of a container.  For example, we can...

2. Run `apt-get update && apt-get install -y htop`
3. Run `htop`

Once done playing, exit out of the running container by typing `exit`

# Part 4 - Interacting with a Container - Web and Networking
## Description

So far we've been looking at running containers from the command line, but lets play with it a bit more from the networking layer.

`docker ps` helps show what ports we have opened, and by default docker will open it on the local machine, and will be listening on all interfaces.  This can be customized.

## Part 4a - Networking

1.  Run `docker ps` again from the command line, and note the output:

```text
user@qlab:~$ docker ps
CONTAINER ID   IMAGE                                          COMMAND                  CREATED          STATUS          PORTS                                     NAMES
629b712ef707   thedarktrumpet/docker-tcp-with-go:monolithic   "/docker-entrypoint.…"   10 minutes ago   Up 10 minutes   0.0.0.0:11111->80/tcp, :::11111->80/tcp   monolithic
user@qlab:~$ 
```

2.  Looking under the "PORTS" section, note the port opened up, 11111.
3.  Open a web browser and navigate to the **host**, with port 11111
    - If you are using the lab I provided, and use qemu, your url may be: http://localhost:11111
	- If you're using docker on your own machine, then the url **is**: http://localhost:11111

4. When done with this section, type: `docker kill monolithic`

# Part 5 - Mounting local directories (good for development)
## Description
When developing in Docker, or developing what may be a good Docker image, mounting local directories is a good idea.  If the Docker image needs to retain state, mounted folders are one of the ways to go.

## Part 5a - Starting Docker with local folder

1. `cd` into the directory with the source code, if using my image, then `cd ~/docker-tcp-with-go`
2. Run: `docker run -d -p 11111:80 -v $(pwd):/code --rm --name monolithic thedarktrumpet/docker-tcp-with-go:monolithic`
3. Run: `docker ps`
4. Run: `docker exec -it monolithic /bin/bash`
5. cd, and ls the /code directory.

Running the above 4 items, you should have the following:

```text
user@qlab:~/docker-tcp-with-go$ docker run -d -p 11111:80 -v $(pwd):/code --rm --name monolithic thedarktrumpet/docker-tcp-with-go:monolithic
63c7a8237e339df52b40186a25c91fb305b07b1c29337c08672f951b30c6d3d1
user@qlab:~/docker-tcp-with-go$ docker ps
CONTAINER ID   IMAGE                                          COMMAND                  CREATED         STATUS         PORTS                                     NAMES
63c7a8237e33   thedarktrumpet/docker-tcp-with-go:monolithic   "/docker-entrypoint.…"   7 seconds ago   Up 2 seconds   0.0.0.0:11111->80/tcp, :::11111->80/tcp   monolithic
user@qlab:~/docker-tcp-with-go$ docker exec -it monolithic /bin/bash
root@63c7a8237e33:/# cd /code
root@63c7a8237e33:/code# ls
README.md  build_all_and_deploy.sh  client  docker  docs  image  scenarios  server
root@63c7a8237e33:/code#
```

6. Type: `echo 'hello' > hello_world`
7. Type: `exit`
8: Type: `ls` then `cat hello_world`

Running the above 3 lines, you should see:

```text
root@63c7a8237e33:/code# echo 'hello' > hello_world
root@63c7a8237e33:/code# exit
exit
user@qlab:~/docker-tcp-with-go$ ls
build_all_and_deploy.sh  client  docker  docs  hello_world  image  README.md  scenarios  server
user@qlab:~/docker-tcp-with-go$ cat hello_world 
hello
user@qlab:~/docker-tcp-with-go$
```

9. Bring down/kill the container: `docker kill monolithic`

# Part 6 - Docker Compose
## Description
Docker Compose is an option for orchestrating container creation within Docker.  There are alternatives, but `docker-compose` is a great option.
## Part 6a - Invoking Docker Compose

1. `cd` into the repository code.  If using the image I provided, then `cd ~/docker-tcp-with-go`
2. Type: `cd scenarios/04-micro-docker-compose`
3. Type `docker-compose up -d`

After running the above, you should get the following:

```text
user@qlab:~/docker-tcp-with-go/scenarios/04-micro-docker-compose$ docker-compose up -d
Creating network "04-micro-docker-compose_default" with the default driver
Creating api ... done
Creating client ... done
Creating web    ... done
```

4. Navigate to the web interface, like in 4a.3:
   - If you are using the lab I provided, and use qemu, your url may be: http://localhost:11111
   - If you're using docker on your own machine, then the url **is**: http://localhost:11111

5. While keeping the web interface up, run the following: 
`docker run -d --link api --net 04-micro-docker-compose_default --name client_2 --rm thedarktrumpet/docker-tcp-with-go:micro_client`

6. Look at the network interface, we now have two clients.

7. Run `docker ps` and you should see the following:

```text
user@qlab:~/docker-tcp-with-go/scenarios/04-micro-docker-compose$ docker ps
CONTAINER ID   IMAGE                                            COMMAND                  CREATED          STATUS          PORTS                                     NAMES
438577fa7ad7   thedarktrumpet/docker-tcp-with-go:micro_client   "/bin/sh -c /src/sta…"   56 seconds ago   Up 51 seconds                                             client_2
426627882f69   thedarktrumpet/docker-tcp-with-go:micro_web      "/docker-entrypoint.…"   8 minutes ago    Up 8 minutes    0.0.0.0:11111->80/tcp, :::11111->80/tcp   web
65941175dea7   thedarktrumpet/docker-tcp-with-go:micro_client   "/bin/sh -c /src/sta…"   8 minutes ago    Up 8 minutes                                              client
bdd43a55bf18   thedarktrumpet/docker-tcp-with-go:micro_api      "/bin/sh -c /src/sta…"   8 minutes ago    Up 8 minutes                                              api
```

7. Run `docker-compose down` and you'll notice an error.  Because we had something outside docker compose hop on the network, it kept the network around.  This is despite that `docker ps` is now empty.

8. Run `docker network rm 04-micro-docker-compose_default` to clean up the network.

# Part 7 - Cleanup of Images
## Description
`docker rm` and `docker rmi` are used to clean up containers and images respectively.
## Part 7a - Removing monolithic

1. Type: `docker rmi thedarktrumpet/docker-tcp-with-go:monolithic` and you should get the following:

```text
user@qlab:~/docker-tcp-with-go/scenarios/04-micro-docker-compose$ docker rmi thedarktrumpet/docker-tcp-with-go:monolithic
Untagged: thedarktrumpet/docker-tcp-with-go:monolithic
Untagged: thedarktrumpet/docker-tcp-with-go@sha256:2d2a98dfaa9ef96b1bae95578b68d218ff979542d6c5e60c18212e926e5ad71c
Deleted: sha256:fb6385fa752ed00f378aef0a5aeab87c03619871211f354e599bdb18aa2b8109
Deleted: sha256:c206f12cdc1aca0825fb777c0f2f6b70245d536b0676be97f1dc3baf43e42bf0
Deleted: sha256:07ca6bb1bb7884fbf8173b8483f3f52bf1b2e2c715c38171ff1eff9af81e345c
Deleted: sha256:100a1549eed599b1cd3adcb4ff8ce913317e68afd352d51ec024c636e73d0fb3
Deleted: sha256:17962865f5c6f5cbbe32dc306b31527ea311a85e7be4e0aff5dc27048f51373a
Deleted: sha256:3e784bb3b5e6d6672a85b294f996fac3b714183163e8d171bf8a1e393f76195a
Deleted: sha256:9105f2b9313dfe5fa8ebcfa90e129c80032815ac2986c592e1efa8409fb1be88
user@qlab:~/docker-tcp-with-go/scenarios/04-micro-docker-compose$
```

# Part 8 - Building of Images 
## Description
There are no steps associated with this part.  But, more references, and a description (likely we won't get to this in the presentation).  Dockerfiles are used to create a Docker image

A simple example of all this is located at: https://github.com/TheDarkTrumpet/docker-tcp-with-go/blob/master/docker/monolithic/

The files, and their meaning are:

* Dockerfile - used to control the creation of the image
* build.sh - A shell script for building all artifacts and invoking docker build
* nginx.conf - A config file we'll use in our container
* start.sh - The entry point, useful because I'm running multiple components in a container

To create a docker container, once everything's ready, run `docker build -t <TAG_NAME> .`  This will look for a Dockerfile in the directory you're in, and will invoke the steps present.

# Part 9 - Design Patterns

## Description
There are many ways to design the creation of images, but I strongly feel a micro architecture standpoint is much cleaner.  So, each container has a specific concern ([Separation of Concerns](https://en.wikipedia.org/wiki/Separation_of_concerns)), and you denote the dependencies in the docker-compose file.  The [build directory](https://github.com/TheDarkTrumpet/docker-tcp-with-go/tree/master/docker/micro) and [Compose file](https://github.com/TheDarkTrumpet/docker-tcp-with-go/blob/master/scenarios/04-micro-docker-compose/docker-compose.yml) should be of particular interest in this.

I also strongly suggest spending time with the rest of this repository, running through all the scenarios and hopefully the design patterns will make more sense.  Also, I go through a lot more in the other scenarios that could be of interest.  If you wish to hack at this repository and play with concepts, please do so as well.

