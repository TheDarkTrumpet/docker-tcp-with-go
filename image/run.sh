#!/bin/sh

# KVM broken
# qemu-system-x86_64 -no-acpi -nodefaults -no-user-config -no-reboot -device virtio-serial-device -chardev stdio,id=virtiocon0 -device virtconsole,chardev=virtiocon0 -vnc :1 -net nic -net user,hostfwd=tcp::7777-:22,hostfwd=tcp::11111-:11111 -smp 4 -cpu host -name debian -m 2048 -drive format=raw,file=debian.img -enable-kvm -daemonize

# Fallback
qemu-system-x86_64 -no-user-config -no-reboot -vnc :1 -net nic -net user,hostfwd=tcp::7777-:22,hostfwd=tcp::11111-:11111 -smp 4 -name debian -m 2048 -drive format=raw,file=debian.img -daemonize
