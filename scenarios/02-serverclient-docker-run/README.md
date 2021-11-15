# 02-serverclient-docker-run

## Introduction

This tutorial will help in building 2 images.  The server image will contain both the nginx and api host, and the 
client will only contain the client.

It's important to run each part entirely, including the cleanup, between each activity.

## Steps to Build

1. cd to `docker-tcp-with-go/docker/server_client`
2. In each of the folders, client and server, run the following:
   - `./build.sh`

## If Unable to Build

If you're unable to build the project for whatever reason, you can find the code at:

https://hub.docker.com/r/thedarktrumpet/docker-tcp-with-go

Run `docker pull thedarktrumpet/docker-tcp-with-go:server_client_server`
and `docker pull thedarktrumpet/docker-tcp-with-go:server_client_client`

# Part 1 - Daemon server, non-daemon clients

Please note, you will notice the below don't work.  It's intentional, please still follow through with these steps.

## Steps to Run
1. Run the server, with the following command:

```shell
docker run -d -p 11111:80 --rm --name server thedarktrumpet/docker-tcp-with-go:server_client_server
```

2. Run the client, with the following command:

```shell
docker run --name client --rm thedarktrumpet/docker-tcp-with-go:server_client_client
```

3. Open a web browser and visit http://localhost:11111

## Steps to Clean Up

1. Type `docker kill server`
2. Type `docker kill client`

## Explanations

We've seen all this already from a syntax statement in `01-monolithic-docker-run`, but notice how the server and client
aren't talking together.  In fact, when you ran the client, you probably saw something like:

```shell
dthole@workstation server_client/client (master *%)  docker run --rm --name client thedarktrumpet/docker-tcp-with-go:server_client_client
Attempting to connect to server:9999
dial tcp: lookup server on 10.0.3.20:53: no such host
dthole@workstation server_client/client (master *%)
```

Containers have a level of isolation by default.  This partly depends on their networking configuration, as well as the
`--link` option.

# Part 2 - Daemon server, non-daemon clients and link

## Steps to Run

1. Run the server, with the following command:

```shell
docker run -d -p 11111:80 --rm --name server thedarktrumpet/docker-tcp-with-go:server_client_server
```

2. Run the client, with the following command:

```shell
docker run --link server --name client --rm thedarktrumpet/docker-tcp-with-go:server_client_client
```

3. Open a web browser and visit http://localhost:11111

## Steps to Clean Up

1. Type `docker kill server`
2. Type `docker kill client`

## Explanations

The only thing we added here is the `--link server`.  What this does in the background is adds the client to the same
internal network as the server, and adds an entry in the /etc/hosts file for that container.  This allows
the container to **always** reference the server by the name, server.  It knows this because in the docker build file
for the client, the actual `start.sh` line has the following:

```shell
./client server 9999
```

The first argument to client is the server name (or IP address) to connect.  It's looking up server.

You can verify all this yourself through some extra poking.  You can run the following, while both the server and client
are running:

```shell
docker exec -it client /bin/bash
cat /etc/hosts
```
You should see something like the following:
```shell
dthole@workstation server_client/client (master *%) » docker exec -it client /bin/bash
root@f9cd81a495f5:/# cat /etc/hosts
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
172.17.0.2	server ce8d7ad8d05e
172.17.0.3	f9cd81a495f5
root@f9cd81a495f5:/# 
```

It's worth noting that, from the server's standpoint, the reverse isn't true.  If you repeat the above, but only for the
server, you'll likely see the following:

```shell
dthole@workstation server_client/client (master *%) » docker exec -it server /bin/bash
root@ce8d7ad8d05e:/# cat /etc/hosts
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
172.17.0.2	ce8d7ad8d05e
root@ce8d7ad8d05e:/# ping client
bash: ping: command not found
root@ce8d7ad8d05e:/# 
```

We'll see a way to mitigate this in a later scenario.

# Activities

Now that we broke the client and server into smaller components, you can do some extra stuff now.

Try to spawn off more than one client, try them in daemon mode, etc.  Notice how the Network Graph changes as you
continue adding more nodes.  Kill a few of the clients, notice how they disappear from the graph.

One gotcha that is worth mentioning here.  The names of the clients must be unique, so make sure you account for that,
but the same client image can be used.
