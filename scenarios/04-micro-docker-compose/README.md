# 04-micro-docker-compose

## Introduction

This is an extension of `03-micro-docker-run`, and assumes you have already run those steps before this.

## Steps to Build

Please follow `03-micro-docker-run` if you haven't yet.  If you have, the images will be available here.

## If Unable to Build

If you're unable to build the project for whatever reason, and **don't** already have the images below, you can find
them on the following repository.

https://hub.docker.com/r/thedarktrumpet/docker-tcp-with-go

Obtain the images, if you don't have them, as follows:
* `docker pull thedarktrumpet/docker-tcp-with-go:micro_api`
* `docker pull thedarktrumpet/docker-tcp-with-go:micro_web`
* `docker pull thedarktrumpet/docker-tcp-with-go:micro_client`

# Part 1 - Installing Docker Compose

You'll have to install docker-compose, as it generally doesn't come standard with docker.  You can find details at:
https://github.com/docker/compose/

The directions should be clear enough, but it's as simple as loading the file for your architecture from the releases page:
https://github.com/docker/compose/releases


# Part 2 - Using Docker Compose

## Steps to Run
1. Open a terminal and cd into this directory (`scenarios/04-micro-docker-compose`)

2. Run docker compose

```shell
docker-compose up -d
```

3. Open a web browser and visit http://localhost:11111

## Steps to Clean Up

1. While in the `scenarios/04-micro-docker-compose` folder type:
* `docker-compose down`

## Explanations

Docker compose solves the issue we had in `03-micro-docker-run`, in which we had to be very careful about what we were
launching and in what order.  The compose file is a yml file, and can specify dependencies and the like.

What makes docker-compose so nice in this regard is you can manage stuff like volumes, networks, and the like all within
this one file.

# Part 3 - Attaching additional clients to network

One thing we did in `03-micro-docker-run` is the ability to run multiple clients.  One limitation with the 
`docker-compose` method is we now lost that ability.  We can get around that by specifying a network for our client.

But first, when you run `docker-compose up -d`, notice the network line:

```shell
dthole@workstation scenarios/04-micro-docker-compose (master %) » docker-compose up -d
WARNING: The Docker Engine you're using is running in swarm mode.

Compose does not use swarm mode to deploy services to multiple nodes in a swarm. All containers will be scheduled on the current node.

To deploy your application across the swarm, use `docker stack deploy`.

Creating network "04-micro-docker-compose_default" with the default driver
Creating api ... done
Creating client ... done
Creating web    ... done
```

A new network was created, called `04-micro-docker-compose_default`, and all these containers now belong to that. So if
you try and run the same `docker run` command we used in 03, you'll see the following:

```shell
dthole@workstation scenarios/04-micro-docker-compose (master %) » docker run --link api --rm --name client2 thedarktrumpet/docker-tcp-with-go:micro_client
docker: Error response from daemon: Cannot link to /api, as it does not belong to the default network.
dthole@workstation scenarios/04-micro-docker-compose (master %) »
```

To solve this, we replace the `--link` option with `--network` and the network we want, in our case:

```shell
dthole@workstation scenarios/04-micro-docker-compose (master %) » docker run --network 04-micro-docker-compose_default --rm --name client2 thedarktrumpet/docker-tcp-with-go:micro_client 
Attempting to connect to api:9999
172.20.0.5:58670 => 172.20.0.2:9999: and Message! 98081
172.20.0.5:58670 <= 172.20.0.2:9999: and Message! 48957
```

Now, if you view the http://localhost:11111 page, you'll see two clients now exist.

**One word of caution on this**.  Given this client was invoked outside `docker-compose`, the network is still reserved.

So if you run `docker-compose down`, you'll get something like:
```shell
dthole@workstation scenarios/04-micro-docker-compose (master %) » docker-compose down
Stopping web    ... done
Stopping client ... done
Stopping api    ... done
Removing web    ... done
Removing client ... done
Removing api    ... done
Removing network 04-micro-docker-compose_default
ERROR: error while removing network: network 04-micro-docker-compose_default id 3a1b7cd240e9834b0b5100093b340c553e04849f6a1cf53ebd4d226349b801c4 has active endpoints
dthole@workstation scenarios/04-micro-docker-compose (master %) » 
```

To make matters worse, the network won't go away once the client dies:

```shell
dthole@workstation scenarios/04-micro-docker-compose (master %) » docker network ls
NETWORK ID     NAME                              DRIVER    SCOPE
3a1b7cd240e9   04-micro-docker-compose_default   bridge    local
```

So you have to remove it manually:

```shell
dthole@workstation scenarios/04-micro-docker-compose (master %) » docker network rm 04-micro-docker-compose_default 
04-micro-docker-compose_default
```

Most real world scenarios won't run into the problem I just demonstrated, but this is to illustrate more about the
networking layer within Docker.

There's a lot about networks I'm not covering here. But you can specify a network within the `docker-compose.yml` and
customize how it operates (e.g. host only), see https://docs.docker.com/compose/networking/
