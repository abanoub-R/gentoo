#!/bin/sh

# mount needed file systems
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run

# ensure compatability with non-gentoo live-cds
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm
mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm

# drop into system
chroot /mnt/gentoo /bin/bash

# exit
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo
