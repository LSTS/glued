version=\
(
    '1.12.14'
)

url=\
(
    "http://cairographics.org/releases/cairo-$version.tar.xz"
)

md5=\
(
    '27b634113d0f52152d60ae8e2ec7daa7'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libpng/default'
    'pixman/default'
    'libxrender/default'
    'libxext/default'
    'freetype2/default'
    'libxft/default'
)

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"

    "../cairo-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
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
    # Libs:
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libcairo*.so*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
}
