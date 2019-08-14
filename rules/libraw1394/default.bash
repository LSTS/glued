version=\
(
    '2.0.5'
)

url=\
(
    "http://downloads.sourceforge.net/libraw1394/libraw1394-$version.tar.gz"
)

md5=\
(
    '1db64231c78540c32859b591cb8b40cf'
)

configure()
{
    "../libraw1394-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --disable-examples \
        --build="$cfg_host_canonical"
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
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libraw1394*so*; do
        $cmd_target_strip "$f" -o "$cfg_dir_rootfs/lib/$(basename "$f")"
    done
}
