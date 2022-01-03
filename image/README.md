# image

## Purpose

This directory includes build scripts for creating the lab image itself, the redistributable part of this project to, hopefully, make it a bit easier for people to get their feet wet with Docker.

## Using an existing image (recommended)

In this directory, git-lfs is enabled with the image `debian_gold.img.tgz`.  This will need to be decompressed and renamed as `debian.img` for future use.  It's a 20Gb image file, that contains the full stack of what's needed to go through the scenarios presented in this project.

Refer to the `run.sh` file, in this directory, for how to spawn this off in QEMU.  You can also convert it to another virtual machine provider if desired.

The command itself is pretty important to get right.  Specifically the `hostfwd` portions.  This will open 2 ports on your host system for forwarding into the VM itself.

| Port  | Purpose                                         |
|-------|-------------------------------------------------|
| 7777  | SSH access                                      |
| 11111 | The Vue.JS portion in the lab images themselves |

I don't really recommend executing this with direct terminal only.  Use SSH.  This is due to the fact that some of these exercises _will_ freeze up your terminal and make it difficult to do anything.  In other words, `Ctrl-c` will not work.  SSH makes this easier because you have have multiple terminals up, and kill the process (or use `docker kill` on the image) where directed.

## Building your own image

The easiest way to do this is on a Debian-based operating system.  The `create.sh` file exists for this purpose, and relies on `debootstrap` to be installed, as well as various `qemu` packages.  I **strongly recommend** you do not run the script wholesale, and most of this has to be run as root (so run it all as root).  Pay attention to the output, because some of the commands if not in the correct area (such as chroot), will hose your base system.

I plan on providing a Dockerfile that can be used to build the image from a Docker container.
