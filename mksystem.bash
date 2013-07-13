#! /bin/bash
#############################################################################
# Copyright (C) 2007-2012 Laboratório de Sistemas e Tecnologia Subaquática  #
# Departamento de Engenharia Electrotécnica e de Computadores               #
# Rua Dr. Roberto Frias, 4200-465 Porto, Portugal                           #
#############################################################################
# Author: Ricardo Martins                                                   #
#############################################################################
# $Id:: mksystem.bash 1152 2012-09-14 02:06:10Z rasm                      $:#
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

start="$(date +%s)"

./mkpackage.bash "$1" 'base' || exit 1

for pkg in $cfg_packages; do
    ./mkpackage.bash "$1" "$pkg" || exit 1
done

elapsed=$[ $(date +%s)-$start ]
echo -e "[$(date +"%Y-%m-%d %H:%M:%S")] \033[0m\033[1;34mcompleted in ${elapsed}s\033[0m"
