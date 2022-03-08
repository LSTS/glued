version=\
(
    '1.0.6'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/libXau-$version.tar.bz2"
)

md5=\
(
    '4a2cbd83727682f9ee1c1e719bac6adb'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../libXau-$version/configure" \
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
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libXau*so*; do
        dst="$cfg_dir_rootfs/lib/$(basename "$f")"
        cp -v -a "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done
}
