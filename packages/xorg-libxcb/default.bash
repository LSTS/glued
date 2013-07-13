version=\
(
    '1.7'
)

url=\
(
    "http://xcb.freedesktop.org/dist/libxcb-$version.tar.bz2"
)

md5=\
(
    '925699df361b99491165ebc12068056b'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'xorg-libpthread-stubs/default'
    'xorg-libxau/default'
    'xorg-xcb-proto/default'
    'libxslt/host'
)

configure()
{
    "../libxcb-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
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
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libxcb*so*; do
        dst="$cfg_dir_rootfs/lib/$(basename "$f")"
        cp -v -a "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done
}
