yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
yum -y remove kernel-devel
yum -y clean all
rpm --rebuilddb
rm -rf VBoxGuestAdditions_*.iso
rm -rf /tmp/rubygems-*

