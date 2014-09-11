sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# No fsck at boot
sed -i -r 's/(defaults\s+)1 1/\10 0/' /etc/fstab

yum -y install yum-fastestmirror

# Import key first so that yum doesn't complain later.
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

# man : tools are never consistent across platforms.
# nfs-utils : Vagrant's shared folders.
# yum-utils : package-cleanup command.
yum shell -y <<EOM
config exclude cscope ctags doxygen intltool systemtap
update
groupinstall "Development Tools"
install http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
install man nfs-utils yum-utils
install yum-plugin-versionlock
run
EOM
# kernel-devel : VirtualBox Guest Additions.
yum -y install kernel-devel-`uname -r` kernel-headers

rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

# Squash the delay on boot
sed -i '/splashimage/d;s_timeout.*$_timeout=0_;s/ rhgb quiet//g' \
  /boot/grub/grub.conf

# Hotplug always tries to load this and it doesn't play well with
# VirtualBox. Always complains to upgrade BIOS.
echo 'blacklist i2c_piix4' >>/etc/modprobe.d/blacklist.conf

# Disable socket repeated use
echo "options single-request-reopen" >>/etc/resolv.conf

# Delete language support.
rm -rf /usr/share/locale/*/LC_MESSAGES/
localedef --list-archive | \
  grep -vE '^en_US.*' | \
  xargs localedef --delete-from-archive
mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
build-locale-archive

chkconfig --level 2345 auditd on
chkconfig --level 2345 crond on
chkconfig --level  345 netfs on
chkconfig --level  345 nfslock on
chkconfig --level 2345 rpcbind on
chkconfig --level  345 rpcgssd on
chkconfig --level  345 rpcidmapd on
chkconfig --level 2345 sshd on

# Don't upgrade the kernel files after this point.
# VirtualBox Guest Additions will break if it is upgraded.
yum versionlock kernel kernel-devel kernel-doc kernel-firmware kernel-headers

# Rebuild the initrd to include only what's needed.
dracut -f -H
