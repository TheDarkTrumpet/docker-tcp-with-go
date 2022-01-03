#!/bin/sh

# Please note, this must be run as root.
# Also note, HIGHLY beta, run one line at a time when it makes sense.

qemu-img create -f raw debian.img 20G

qemu-nbd --format=raw --connect=/dev/nbd0 debian.img

sfdisk /dev/nbd0 << EOF
,1024,82
;
EOF

mkswap /dev/nbd0p1
mkfs.ext4 /dev/nbd0p2


mkdir disk
mount /dev/nbd0p2 disk

sudo debootstrap --arch=amd64 --include="openssh-server emacs-nox docker.io sudo git qemu-guest-agent" stable disk/ http://httpredir.debian.org/debian/

mount --bind /dev/ disk/dev
chroot disk

mount -t proc none /proc
mount -t sysfs none /sys

apt-get install -y linux-image-amd64 grub2

#grub-install /dev/nbd0 --force
#update-grub2

# Create a user
mkdir /home/user
useradd user -d /home/user -m -s /bin/bash -G docker,sudo
chown user:user /home/user

# Update passwords
echo "root:root" | chpasswd
echo "user:user" | chpasswd

# Now make it user friendly-ish
echo "pts/0" >> /etc/securetty
systemctl set-default multi-user.target
systemctl enable ssh
systemctl enable docker
systemctl enable qemu-guest-agent

# Root Drive
echo "/dev/sda2 / ext4 defaults,discard 0 0" > /etc/fstab

# Networking and hostname
echo 'qlab' > /etc/hostname
echo '127.0.0.1 qlab' >> /etc/hosts

echo > /etc/systemd/network/99-wildcard.network <<EOF
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
grub-install /dev/nbd0 --root-directory=. --modules="biosdisk part_msdos" --force
update-grub2

umount /sys
umount /proc
exit
umount disk/dev

qemu-nbd --disconnect /dev/nbd0

# Likely not needed, using UUIDs
# sed -i 's/nbd0p2/sda2/g' /mnt/boot/grub/grub.cfg

# grub-install /dev/nbd0 --force
# update-grub2
