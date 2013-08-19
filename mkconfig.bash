#! /bin/bash
#############################################################################
# Copyright (C) 2007-2012 Laboratório de Sistemas e Tecnologia Subaquática  #
# Departamento de Engenharia Electrotécnica e de Computadores               #
# Rua Dr. Roberto Frias, 4200-465 Porto, Portugal                           #
#############################################################################
# Author: Ricardo Martins                                                   #
#############################################################################
# $Id:: mkconfig.bash 1629 2013-06-30 11:39:30Z rasm                      $:#
#############################################################################

# Config: GLUED version.
cfg_glued_version='1.8.4'
# Config: GLUED vendor.
cfg_glued_vendor='lsts'

# Check shell type.
if [ -z "$BASH_VERSION" ]; then
    echo "ERROR: you must use bash to run this script."
    exit 1
fi

# Validate command line parameters.
if [ $# -ne 1 ]; then
    echo "Usage: $0 <system>"
    exit 1
fi

# Check if user requested system list.
if [ "$1" = "list" ]; then
    for family in $(ls -1 systems | sort); do
        echo -e "\n  + Family $family"
        find "systems/$family" -name '*.cfg' | egrep -v "devlinks|linux-[0-9.]*.cfg" | while read s; do
            echo "    - $(basename "$s" .cfg)"
        done | sort
    done

    echo ""
    exit 1
fi

# Check number of CPU cores.
if [ -f /proc/cpuinfo ]; then
    cfg_host_cores="$(grep "processor[^:]:" /proc/cpuinfo | wc -l)"
fi

if [ -z "$cfg_host_cores" ]; then
    cfg_host_cores=1
fi

# Find system configuration files.
if [ -f "systems/"*"/$1.cfg" ]; then
    system_cfg="$(echo "systems/"*"/$1.cfg")"

    family_cfg="$(dirname $system_cfg)/config"
    if ! [ -f "$family_cfg" ]; then
        echo "ERROR: no base configuration available for system '$1'"
        exit 1
    fi
    family_dir="$(dirname $family_cfg)"
    family_name="$(basename $family_dir)"
    source "$family_cfg"

    if ! [ -f "$system_cfg" ]; then
        echo "ERROR: no configuration available for system '$1'"
        exit 1
    fi

    source "$system_cfg"

fi

# Read architecture configuration.
if ! [ -f "architectures/$cfg_architecture.cfg" ]; then
    echo "ERROR: configuration for '$1' architecture does not exist"
    exit 1
fi
source "architectures/$cfg_architecture.cfg"

# Creating the mac address if not set in configuration file we create one derivated from the IP address:
if [ -n $cfg_eth_ext_ip ]; then
  ips=(`echo $cfg_eth_ext_ip | sed -e 's/\./\n/g'`)
  for i in "${ips[@]}"
  do
    hip=("${hip[@]}" `printf '%x' $i`)
  done
  cfg_eth_ext_mac="80:c1:${hip[0]}:${hip[1]}:${hip[2]}:${hip[3]}"
fi

# Config: system name.
if [ -z $cfg_sys_name ]; then
  cfg_sys_name="$1"
fi
# Config: system family.
cfg_sys_family="$family_name"
# Config: GLUED source tree base path.
cfg_dir_base="$PWD"
# Config: system configuration folder.
cfg_dir_system="$cfg_dir_base/$family_dir"
# Config: package rules folder.
cfg_dir_packages="$cfg_dir_base/packages"
# Config: configuration rules folder.
cfg_dir_postconfiguration="$cfg_dir_base/postconfiguration"
# Config: package sources folder.
cfg_dir_downloads="$cfg_dir_base/downloads"
# Config: build folder.
cfg_dir_builds="$cfg_dir_base/$cfg_sys_family/builds"
# Config: toolchain destination folder.
cfg_dir_toolchain="$cfg_dir_base/$cfg_sys_family/toolchain"
# Config: root filesystem folder.
cfg_dir_rootfs="$cfg_dir_base/$cfg_sys_family/rootfs"
# Config: system root folder.
cfg_dir_toolchain_sysroot="$cfg_dir_toolchain/$cfg_target_canonical/sysroot"
# Target prefix:
cmd_target_prefix="$cfg_dir_toolchain/bin/$cfg_target_canonical-"
# Config: target C compiler executable.
cmd_target_cc="$cfg_dir_toolchain/bin/$cfg_target_canonical-gcc"
# Config: target C pre-processor executable.
cmd_target_cpp="$cfg_dir_toolchain/bin/$cfg_target_canonical-cpp"
# Config: target C++ compiler executable.
cmd_target_cxx="$cfg_dir_toolchain/bin/$cfg_target_canonical-g++"
# Config: target archiver executable.
cmd_target_ar="$cfg_dir_toolchain/bin/$cfg_target_canonical-ar"
# Config: target linker executable.
cmd_target_ld="$cfg_dir_toolchain/bin/$cfg_target_canonical-ld"
# Config: target strip executable.
cmd_target_strip="$cfg_dir_toolchain/bin/$cfg_target_canonical-strip"
# Config: target archive indexer executable.
cmd_target_ranlib="$cfg_dir_toolchain/bin/$cfg_target_canonical-ranlib"
# Config: host compiler executable.
cmd_host_cc="gcc"
# Command: strip command.
cmd_target_strip="$cmd_target_strip --strip-unneeded"
# Command: command to create folders.
cmd_mkdir="mkdir -pv"
# Command: copy data.
cmd_cp="cp -avr"
# Command: allow execution.
cmd_chmod755="chmod 755"
# Config: host canonical name.
cfg_host_canonical="$($cmd_host_cc -dumpmachine 2> /dev/null)"
# Command: make command with one process.
cmd_make_single="make -j1"
# Command: make command.
cmd_make="make -j$cfg_host_cores"
# Config: rootfs tar file.
if [ -z $cfg_rootfs_tar ]; then
    cfg_rootfs_tar="$cfg_dir_base/$cfg_sys_family/glued-$cfg_glued_version-$cfg_sys_name-rootfs.tar.bz2"
fi
# Config: toolchain tar file.
if [ -z $cfg_toolchain_tar ]; then
    cfg_toolchain_tar="$cfg_dir_base/$cfg_sys_family/glued-$cfg_glued_version-$cfg_sys_family-toolchain-$cfg_host_canonical-$cfg_target_canonical.tar.bz2"
fi

if ! [ -d "$cfg_sys_family" ]; then
    mkdir -p "$cfg_sys_family"
fi &&

# Save configuration values to file.
set \
    | egrep '^cfg_|^cmd_' \
    | awk '{print "export " $0}' \
    > "$cfg_sys_family/$1.bash"

echo "Configuration file written to '$cfg_sys_family/$1.bash'"
