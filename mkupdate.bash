#! /bin/bash
###########################################################################
# GLUED: GNU/Linux Uniform Environment Distribution                       #
# Copyright (C) 2007-2017 Universidade do Porto - Faculdade de Engenharia #
# Laboratório de Sistemas e Tecnologia Subaquática (LSTS)                 #
###########################################################################
# This program is free software; you can redistribute it and/or modify    #
# it under the terms of the GNU General Public License as published by    #
# the Free Software Foundation; either version 2 of the License, or (at   #
# your option) any later version.                                         #
#                                                                         #
# This program is distributed in the hope that it will be useful, but     #
# WITHOUT ANY WARRANTY; without even the implied warranty of              #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU       #
# General Public License for more details.                                #
#                                                                         #
# You should have received a copy of the GNU General Public License       #
# along with this program; if not, write to the Free Software             #
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA           #
# 02110-1301 USA.                                                         #
###########################################################################
# Author: Tiago Marques                                                   #
###########################################################################

update_tool()
{
    rsync -v "$1" root@"$2":/opt/lsts/glued/
    if [ $? -eq 0 ]; then
        return 0
    fi

    scp "$1" root@"$2":/opt/lsts/glued/
    if [ $? -eq 0 ]; then
        return 0
    fi

    return 1
}

# Check command line arguments.
if [ $# -lt 1 ]; then
    echo "Usage: $0 <config>"
    exit 1
fi

# Read system configuration file.
if ! [ -f "$1" ]; then
    echo -e "\e[1;31mERROR: invalid configuration file '$1'\e[0m"
    exit 1
fi

# Read system configuration file.
source "$1"

if [ ! -f "$cfg_rootfs_tar" ];
then
    echo -e "\e[1;31mERROR: You should run ./pkrootfs $1\e[0m"
    exit 1
fi

# check for dirty repo
if [[ "$cfg_glued_git_version" =~ .*-dirty$ ]]
then
    echo -e "\e[1;31mThis glued's version is dirty\e[0m"
fi

# send package to the system
update_tool "$cfg_rootfs_tar" "$cfg_eth_ext_ip"
