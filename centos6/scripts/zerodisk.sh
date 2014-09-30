rm -rf /tmp/* /tmp/.[^.]+
dd if=/dev/zero of=/tmp/clean bs=1M || rm -f /tmp/clean

# Delete wait
sync
sync
sync
