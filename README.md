Introduction
============

GLUED (GNU/Linux Uniform Environment Distribution) is a minimal Linux
distribution targeted at embedded systems.

Configuration
=============

The first step to build GLUED for a particular system is to create a
configuration file. This configuration file contains details about the
system's architecture, packages that will be part of the distribution,
network configuration, etc.

To list all available systems issue the following command on a
terminal:

./mkconfig.bash list

Once you have identified the name of the system you want to build,
issue the following command, replacing \<system_name> with the name of
that system:

./mkconfig.bash \<system_name>

Building
========

After creating a configuration file, you are ready to compile all the
necessary packages.

To start the compilation process, issue the following command:

./mksystem.bash \<config_file>

Archives
========

After the system is compiled you can create archives for distributing,
developing or upgrading existing installations.

Toolchain Archive
-----------------

To create a package containing all the necessary tools to
cross-compile C/C++ programs for you target system, issue the
following command:

./pktoolchain.bash \<config_file>

Root Filesystem Archive
-----------------------

The root filesystem archive contains all files necessary to run a
GLUED system. It allows you to upgrade existing GLUED systems and
initialize storage devices. To create a root filesystem archive, issue
the following command:

./pkrootfs.bash \<config_file>

Initializing Storage Devices
============================

Initializing storage devices for GLUED involves:

    * Partitioning the storage device
    * Creating filesystems
    * Populating filesystems
    * Installing a bootloader if applicable

To perform all of the previous steps, you must first identify the
target block device file and then issue the following command (as
root):

./mkdisk.bash \<config_file> \<block_device>

Example
=======

Building GLUED for the system LAUV Seacon 1 and initializing a compact
flash card with the block device file /dev/sdd:

./mkconfig.bash lauv-seacon-1 &&
./mksystem.bash lctr-a6xx/lauv-seacon-1.bash &&
./pktoolchain.bash lctr-a6xx/lauv-seacon-1.bash &&
./pkrootfs.bash lctr-a6xx/lauv-seacon-1.bash &&
sudo ./mkdisk.bash lctr-a6xx/lauv-seacon-1.bash /dev/sdd
