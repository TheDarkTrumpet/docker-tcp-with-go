# 01-Monolithic-docker-run

## Introduction

These steps will build the monolithic docker image, and run it using docker run
and verifying the contents in a web browser

It's important to run each part entirely, including the cleanup, between each activity.

## Steps to Build

1. cd to `docker-tcp-with-go/docker/monolithic`
2. Run `./build.sh`

## If Unable to Build

If you're unable to build the project for whatever reason, you can find the code at:

https://hub.docker.com/r/thedarktrumpet/docker-tcp-with-go

Run `docker pull thedarktrumpet/docker-tcp-with-go:monolithic` for these steps.

# Part 1 - Non-Daemon, simple execution

## Steps to Run
1. Run the following at the command line:

```bash
docker run -p 11111:80 thedarktrumpet/docker-tcp-with-go:monolithic
```

2. Open a web browser and visit http://localhost:11111

During these steps, you'll see logs in the terminal you ran your most recent command from.  Test and verify output in this step.

## Steps to Clean Up

`Ctrl+c` does not escape
properly, to kill this, do the following:

1. Type `docker ps` in a second active terminal
2. Find the hash to kill  (Under `Container ID`)
3. Run docker kill `<HASH_ID>`
4. Run docker rm `<HASH_ID>`

## Explanations

`docker run` is one way to spawn off a container from a built image.  In this case we have only two
options that we're passing it:

`-p 11111:80` says to expose the port `11111` on your local box to port `80` internal.  This is the same as opening
a firewall port on your local router

`thedarktrumpet/docker-tcp-with-go:monolithic` is the name of the `image:tag` for what we
want to run.  In this case, `thedarktrumpet` is the user name, and the project name is `docker-tcp-with-go` and the tag
is `monolithic`

# Part 2 - Named Daemon

## Steps to Run
1. Run the following at the command line:

```bash
docker run -d -p 11111:80 --rm --name monolithic thedarktrumpet/docker-tcp-with-go:monolithic
```

2. Open a web browser and visit http://localhost:11111

During this phase, you won't see output to the console, you can view the logs by running:

`docker logs monolithic`

## Steps to Clean Up

1. Type `docker kill monolithic`

## Explanations

Everything we said in the previous explanation holds, in addition to the following options helping us out:

`-d` will invoke this as a daemon, so we won't actively see output on our screen.  For anything deployment wise, 
this'll be how things are run.

`--rm` will remove the container when process finishes.  Note in our cleanup steps how much shorter it was?  When we
were doing the `docker rm` commands, we were cleaning up that container.  With `--rm`, that's done for us.

`--name` is also a nice quality of life option, which will name our running container so we can better identify it in
the future.

One word of caution, though.  The image name and tag need to go at the end of a docker run statement.  Options should 
exist only in the first part of the statement, the image being the last.