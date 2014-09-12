sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# No fsck at boot
sed -i -r 's/(defaults\s+)1 1/\10 0/' /etc/fstab

# Squash the delay on boot
sed -i '/splashimage/d;s_timeout.*$_timeout=0_;s/ rhgb quiet//g' \
  /boot/grub/grub.conf

# Hotplug always tries to load this and it doesn't play well with
# VirtualBox. Always complains to upgrade BIOS.
echo 'blacklist i2c_piix4' >> /etc/modprobe.d/blacklist.conf

# Disable socket repeated use
echo "options single-request-reopen" >> /etc/resolv.conf

# Delete language support.
rm -rf /usr/share/locale/*/LC_MESSAGES/
localedef --list-archive | \
  grep -vE '^en_US.*' | \
  xargs localedef --delete-from-archive
mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
build-locale-archive
