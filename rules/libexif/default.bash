version=\
(
    "0.6.21"
)

url=\
(
    "http://sourceforge.net/projects/libexif/files/libexif/$version/libexif-$version.tar.bz2"
)

md5=\
(
    "27339b89850f28c8f1c237f233e05b27"
)

maintainer=\
(
    "Renato Caldas <rmsc@fe.up.pt>"
)

configure()
{
    ../libexif-$version/configure \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --disable-static \
        --enable-shared
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
    cp -a $cfg_dir_toolchain_sysroot/usr/lib/libexif*so* "$cfg_dir_rootfs/lib"
    $cmd_target_strip -v "$cfg_dir_rootfs/lib/libexif.so"*
}
