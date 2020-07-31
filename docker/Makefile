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
VERSION := 2020.07.24
VOLUME  := $(CURDIR)/..
DNS     := 8.8.8.8

all:
	docker build -t $(TAG):$(VERSION) .

shell:
	docker run -w $(VOLUME) --dns=$(DNS) -i -a stdin -a stdout -v $(VOLUME):$(VOLUME) -t $(TAG):$(VERSION)

clean:
	@echo "* Stopping docker service..."
	@sudo systemctl stop docker
	@echo "* Cleaning docker service..."
	@sudo rm -rf /var/lib/docker
	@echo "* Starting docker service..."
	@sudo systemctl start docker
	@echo "* Done."

delete_img:
	@sudo docker system prune -a
