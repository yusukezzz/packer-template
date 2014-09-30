sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# No fsck at boot
sed -i -r 's/(defaults\s+)1 1/\10 0/' /etc/fstab

# Faster ssh connection
sed -i -r 's/#(UseDNS).*/\1 no/' /etc/ssh/sshd_config

# Disable socket repeated use
echo "options single-request-reopen" >> /etc/resolv.conf
