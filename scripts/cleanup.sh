# Rebuild the initrd to include only what's needed.
dracut -f -H

yum -y remove kernel-devel
yum -y clean all
rpm --rebuilddb
rm -rf VBoxGuestAdditions_*.iso
