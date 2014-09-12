yum -y remove kernel-devel
yum -y clean all
rpm --rebuilddb
rm -rf VBoxGuestAdditions_*.iso
