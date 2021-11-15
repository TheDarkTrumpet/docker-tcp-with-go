# docker-tcp-with-go

# Introduction

This repository is designed to give an overview of how to use Docker, from a fairly high level using a project from the 
"ground up". The client/server application was created in a way to be lightweight, visual, and intuitive in how this
applies to, and can be encapsulated in, Docker.

# Project Structure
| Folder | Purpose |
|--------|---------|
| client | Go client (makes TCP connections to server/api) |
| server/api | Go server, runs API front, as well as a TCP server |
| server/frontend | Vue.js application that has two tabs, network graph and logs |
| scenarios | Readme and docker-compose files for a guided walk-through |
| docs      | Presentation slides, draw.io, etc. |
| docker    | The categories of docker files used in the scenarios |

# Project Dependencies

At a minimum, you need to have docker and docker-compose installed.

If you wish to build the applications/containers, you need to have the following installed:
1. golang
2. npm

# Where to Get Started?

I recommend starting to read through the `scenario/*` directories.  They're numbers from 01-04, and start with 01.  
These are meant as a tutorial.

This will update with links to my blog and videos as I develop them before my formal presentation in Dec.

# References and Links

* Dockerhub Repository: https://hub.docker.com/r/thedarktrumpet/docker-tcp-with-go
