###########################################################################
# GLUED: GNU/Linux Uniform Environment Distribution                       #
# Copyright (C) 2007-2014 Universidade do Porto - Faculdade de Engenharia #
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
# Author: Ricardo Martins                                                 #
###########################################################################

nfo1()
{
    echo -e "[$(date +"%Y-%m-%d %H:%M:%S")] \033[0m\033[1;34m* $*\033[0m"
}

nfo2()
{
    echo -e "[$(date +"%Y-%m-%d %H:%M:%S")] \033[0m\033[0;35m** $*\033[0m"
}

ok()
{
    echo -e "[$(date +"%Y-%m-%d %H:%M:%S")] \033[0m\033[0;32m** $*\033[0m"
}

err()
{
    echo -e "[$(date +"%Y-%m-%d %H:%M:%S")] \033[0m\033[1;31mERROR: $*\033[0m"
}

ucat()
{
    case "$1" in
        *.gz)
            zcat "$1"
            ;;
        *)
            cat "$1"
            ;;
    esac
}
