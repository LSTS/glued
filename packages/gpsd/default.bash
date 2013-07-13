version=\
(
    "2.95"
)

url=\
(
    "http://download.berlios.de/gpsd/gpsd-$version.tar.gz"
)

md5=\
(
    "12535a9ed9fecf9ea2c5bdc9840da5ae"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    ../gpsd-$version/configure \
        --prefix="$cfg_dir_rootfs/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --disable-dbus \
        --disable-libQgpsmm
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_target_strip .libs/gpsd -o $cfg_dir_rootfs/usr/bin/gpsd &&
    for l in .libs/libgps*so*; do
        $cmd_target_strip "$l" -o $cfg_dir_rootfs/usr/lib/"$(basename $l)"
    done

    cp "$cfg_package_spec_dir"/services/gpsd "$cfg_dir_rootfs/etc/rc.d"
}
