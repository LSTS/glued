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

FROM debian:8

MAINTAINER Ricardo Martins <rasm@oceanscan-mst.com>
MAINTAINER Pedro Gonçalves <pedro@lsts.pt>

ENV DEBIAN_FRONTEND noninteractive

# Update distro.
RUN echo "deb http://ftp.us.debian.org/debian testing non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.fe.up.pt/ubuntu xenial main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.fe.up.pt/ubuntu xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.fe.up.pt/ubuntu xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 40976EAF437D05B5
RUN apt-get update -y
RUN apt-get dist-upgrade -y
RUN apt-get autoremove -y
RUN apt-get autoclean -y
RUN apt-get install -y build-essential
RUN apt-get install -y g++-multilib
RUN apt-get install -y make
RUN apt-get install -y wget
RUN apt-get install -y bzip2
RUN apt-get install -y git
RUN apt-get install -y file
RUN apt-get install -y vim
RUN apt-get install -y nasm
RUN sed -i 's#mozilla\/DST_Root_CA_X3.crt#!mozilla\/DST_Root_CA_X3.crt#g' /etc/ca-certificates.conf && update-ca-certificates --fresh
