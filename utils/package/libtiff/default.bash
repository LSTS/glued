version=\
(
    "4.0.2"
)

url=\
(
    "ftp://ftp.remotesensing.org/pub/libtiff/tiff-$version.tar.gz"
)

md5=\
(
    "04a08fa1e07e696e820a0c3f32465a13"
)

maintainer=\
(
    "Renato Caldas <rmsc@fe.up.pt>"
)

configure()
{
    ../tiff-$version/configure \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --disable-static \
        --enable-shared \
        --enable-cxx
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
    cp -a $cfg_dir_toolchain_sysroot/usr/lib/libtiff*so* "$cfg_dir_rootfs/lib"
    $cmd_target_strip -v "$cfg_dir_rootfs/lib/libtiff.so"*
}
