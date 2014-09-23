# Rebuild the initrd to include only what's needed.
dracut -f -H

# Remove large size packages
yum -y remove cpp perl git subversion kernel-devel kernel-firmware kernel-headers
yum -y clean all
rpm --rebuilddb
