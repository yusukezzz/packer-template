VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
cd /tmp
mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
chkconfig vboxadd-x11 off
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso

# Don't upgrade the kernel files after this point.
# VirtualBox Guest Additions will break if it is upgraded.
yum versionlock kernel kernel-devel kernel-doc kernel-firmware kernel-headers
