version=\
(
    "3.1.8"
)

url=\
(
    "ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/pciutils-$version.tar.gz"
)

md5=\
(
    "79312f138311d29291c7d44d624cd37e"
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
        PREFIX="/usr" \
        SHAREDIR=/usr/share/pciutils
}

host_install()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/include
    mkdir -p $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/lib
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    $cmd_make \
        CC=$cmd_target_cc \
        INCDIR="$cfg_dir_output_toolchain_sysroot/usr/include" \
        LIBDIR="$cfg_dir_output_toolchain_sysroot/usr/lib" \
        install-lib
}

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/bin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    mkdir -p "$cfg_dir_output_rootfs/usr/share/pciutils" &&
    cp pci.ids.gz "$cfg_dir_output_rootfs/usr/share/pciutils" &&
    $cmd_target_strip lspci -o $cfg_dir_output_rootfs/usr/bin/lspci &&
    $cmd_target_strip setpci -o $cfg_dir_output_rootfs/usr/bin/setpci

    tar -czf ../pciutils-v$version.tar.gz ../rootfs ../toolchain
}
