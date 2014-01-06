version=\
(
    '1.6.8'
)

url=\
(
    "http://downloads.sourceforge.net/project/libpng/libpng16/$version/libpng-$version.tar.xz"
)

md5=\
(
    '51ce71a1642cdde1f4485a7ff82193c0'
)

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target="$cfg_target_canonical"            \
        --host="$cfg_target_canonical"              \
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
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libpng*.so*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
}
