#! /bin/bash
#############################################################################
# $Id:: Helps deploying an archive to a folder in an easy way.            $:#
#############################################################################

# Check shell type.
if [ -z "$BASH_VERSION" ]; then
    echo "ERROR: you must use bash to run this script."
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Usage: $0 <config>"
    exit 1
fi

if ! [ -f "$1" ]; then
    echo "ERROR: configuration file '$1' does not exist."
    exit 1
fi

source "$1"

# Creating a new folder:
target="${cfg_dir_base}/nfs/${cfg_hostname}"
sudo rm -rf ${target}
mkdir -p ${target}

# Copy the content of the file to our NFS folder:
sudo tar -pxf ${cfg_rootfs_tar} -C ${target}

# We want our resolve file and host file:
sudo rm "${target}/etc/resolv.conf"
sudo cp "/etc/resolv.conf" "${target}/etc/resolv.conf"
sudo rm "${target}/etc/hosts"
sudo cp "/etc/hosts" "${target}/etc/hosts"

