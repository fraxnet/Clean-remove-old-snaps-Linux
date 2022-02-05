#!/bin/bash
# fraxnet.com
# version 0.1

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
#apt-get update && apt-get upgrade
snap --version

echo "Current usage:";
du -h /var/lib/snapd/snaps
echo "";

set -eu

if [ "${UID}" -ne 0 ]; then
    echo "This script should be run as root. Try 'sudo'."
    exit 1

LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
#apt-get update && apt-get upgrade

echo "Usage after removing old versions:"
du -h /var/lib/snapd/snaps

# Optionally to change the default  
#Starting from snap v2.34 and later, you can limit the maximum number of snap revisions stored for each package 
# by setting the refresh.retain option (a number between 2 and 20, default value is 3).
# in the terminal type : sudo snap set system refresh.retain=2 


