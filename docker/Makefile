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

TAG     := glued
VERSION := 2016.05.0
VOLUME  := $(CURDIR)/..
DNS	:= 8.8.8.8
GITWORKTREE := $(shell [ "$$(git worktree list | wc -l)" -gt 1 ] && echo 'yes')

ADDVOLUME   := $(VOLUME)/..:$(VOLUME)/..

all:
	docker build -t $(TAG):$(VERSION) .

shell:
	$(if $(GITWORKTREE), @echo "GITWORKTREE WAS DETECTED (ASSUMING MAIN REPO Git PATH '../')" ,)
	docker run -w $(VOLUME) --dns=$(DNS) -i -a stdin -a stdout -v $(VOLUME):$(VOLUME) $(if $(GITWORKTREE),-v $(ADDVOLUME),) -t $(TAG):$(VERSION)
