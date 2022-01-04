#!/bin/sh

qemu-system-x86_64 -vnc :1 -net nic -net user,hostfwd=tcp::7777-:22,hostfwd=tcp::11111-:11111 -smp 4 -cpu host -name debian -m 2048 -drive format=raw,file=debian.img -enable-kvm -daemonize
