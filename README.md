# docker-tcp-with-go

# Introduction

This repository is designed to give an overview of how to use Docker, from a fairly high level using a project from the 
"ground up". The client/server application was created in a way to be lightweight, visual, and intuitive in how this
applies to, and can be encapsulated in, Docker.

# Project Structure
| Folder | Purpose |
|--------|---------|
| client | Go client (makes TCP connections to server/api) |
| docs      | Presentation slides, draw.io, etc. |
| docker    | The categories of docker files used in the scenarios |
| image     | Scripts for creating (as well as an gold copy), of the lab |
| scenarios | Readme and docker-compose files for a guided walk-through |
| server/api | Go server, runs API front, as well as a TCP server |
| server/frontend | Vue.js application that has two tabs, network graph and logs |

# Project Dependencies

At a minimum, you need to have docker and docker-compose installed on a system (or see the provided lab below)

If you wish to build the applications, outside the containers, you need to have the following installed:
1. golang
2. npm

# Where to Get Started?

The two main directories that'll be of immediate interest are the `docs/*` and `scenario/*`:

* `docs/*` provides the slides, notes, and handouts for videos and presentations.
* `scenario/*` provides a step-by-step instruction to walk you through doing stuff in Docker.  Start with `01`.  The non-numeric start ones are for public presentations I'm doing on the topic.


# Running Along with the Scenarios

If you'd like to run along with the scenarios, there are two options you can do to achive this:

## 1. Run Docker on Your Main System

You can install Docker on both Windows, OSX, as well as Linux.  It's free.  But, given the number of types of systems people are using, I won't provide detailed instructions here.  What I will say is that if you're using Windows, look for `Docker CE for Windows`, and for OSX `Docker Desktop for Mac`.  For linux, if using a Debian based one, https://docs.docker.com/engine/install/debian/ should help out a lot.

## 2. Use the Provided Lab

Because #1, above, can be a be a bit much if you're unsure if you'd like and use Docker, I also provided an virtual machine image that has everything included.  You can navigate to the `image` directory in this repository to build your own, or use the `debian_gold.tgz` file in the `image` directory with QEMU.  The README in the `image` directory has more information on all this.

# References and Links

* Dockerhub Repository: https://hub.docker.com/r/thedarktrumpet/docker-tcp-with-go
