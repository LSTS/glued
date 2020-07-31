version=\
(
    "3.1.8"
)

url=\
(
    "http://ftp.riken.jp/Linux/kernel.org/software/utils/pciutils/pciutils-$version.tar.gz"
)

md5=\
(
    "8362de952d95835d8bf5e5d27f723d66"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

build()
{
    $cmd_make \
        CC=$cmd_target_cc \
        ZLIB=yes \
        PREFIX=/usr \
        SHAREDIR=/usr/share/pciutils
}

host_install()
{
    $cmd_make \
        CC=$cmd_target_cc \
        INCDIR="$cfg_dir_toolchain_sysroot/usr/include" \
        LIBDIR="$cfg_dir_toolchain_sysroot/usr/lib" \
        install-lib
}

target_install()
{
    mkdir -p "$cfg_dir_rootfs/usr/share/pciutils" &&
    cp pci.ids.gz "$cfg_dir_rootfs/usr/share/pciutils" &&
    $cmd_target_strip lspci -o $cfg_dir_rootfs/usr/bin/lspci &&
    $cmd_target_strip setpci -o $cfg_dir_rootfs/usr/bin/setpci
}
