#!/bin/sh

# Please note, this must be run as root.
# Also note, HIGHLY beta, run one line at a time when it makes sense.

# Image setup, base and partitions
qemu-img create -f raw debian.img 20G

modprobe nbd
qemu-nbd --format=raw --connect=/dev/nbd0 debian.img

sfdisk /dev/nbd0 << EOF
,1024,82
;
EOF

mkswap /dev/nbd0p1
mkfs.ext4 /dev/nbd0p2

# Mount disk and install base system
mkdir disk
mount /dev/nbd0p2 disk

debootstrap --arch=amd64 --include="openssh-server emacs-nox docker.io sudo git qemu-guest-agent ca-certificates locales" stable disk/ http://httpredir.debian.org/debian/

# Mount and chroot into it
mount --bind /dev/ disk/dev
chroot disk

mount -t proc none /proc
mount -t sysfs none /sys

# Generate locale and install packages we couldn't do in the bootstrap step (due to kernel gen primarily)
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen

apt-get install -y linux-image-amd64 grub2

# Create a user
useradd user -d /home/user -m -s /bin/bash -G docker,sudo

# Update passwords
echo "root:root" | chpasswd
echo "user:user" | chpasswd

# Now make it user friendly-ish
echo "pts/0" >> /etc/securetty
systemctl set-default multi-user.target
systemctl enable ssh
systemctl enable docker
systemctl enable qemu-guest-agent

# Root Drive and Swap
echo "/dev/sda1 none swap sw 0 0" > /etc/fstab
echo "/dev/sda2 / ext4 defaults,discard 0 0" >> /etc/fstab

# Networking and hostname
echo 'qlab' > /etc/hostname
echo '127.0.0.1 qlab' >> /etc/hosts

cat > /etc/systemd/network/99-wildcard.network <<EOF
[Match]
Name=en*

[Network]
DHCP=yes
EOF

systemctl enable systemd-networkd

# Setup User-based stuff
sudo su user -
cd ~

git clone https://github.com/TheDarkTrumpet/docker-tcp-with-go.git

exit

# Finishing touches
grub-install /dev/nbd0 --force
update-grub2

umount /sys
umount /proc
exit
umount disk/dev
umount disk

qemu-nbd --disconnect /dev/nbd0
