###########################################################################
# GLUED: GNU/Linux Uniform Environment Distribution                       #
# Copyright (C) 2016 OceanScan - Marine Systems & Technology, Lda.        #
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

FROM debian:9

MAINTAINER Ricardo Martins <rasm@oceanscan-mst.com>
MAINTAINER Pedro Gonçalves <pedro@lsts.pt>

ENV DEBIAN_FRONTEND noninteractive

# Update distro.
RUN echo "deb http://ftp.us.debian.org/debian testing non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.fe.up.pt/ubuntu xenial main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.fe.up.pt/ubuntu xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.fe.up.pt/ubuntu xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y gnupg2
RUN apt-get install -y apt-utils
RUN apt-get install -y gpgv
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 40976EAF437D05B5
RUN apt-get update -y
RUN apt-get install -y apt-utils
RUN apt-get dist-upgrade -y
RUN apt-get install -y g++-5
RUN apt-get install -y gcc-5
RUN apt-get install -y wget
RUN apt-get install -y bzip2
RUN apt-get install -y git
RUN apt-get install -y g++-multilib
RUN apt-get install -y file
RUN apt-get install -y kmod
RUN apt-get install -y vim
RUN apt-get install -y nasm
RUN apt-get install -y build-essential
RUN apt-get install -y make
RUN apt-get install -y bison
RUN apt-get install -y flex
RUN apt-get install -y libssl-dev
RUN apt-get install -y libncurses-dev
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 --slave /usr/bin/g++ g++ /usr/bin/g++-5
