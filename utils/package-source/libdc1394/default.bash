version=\
(
    '2.1.2'
)

url=\
(
    "http://downloads.sourceforge.net/libdc1394/libdc1394-$version.tar.gz"
)

md5=\
(
    'b85f1ade88d8d96688d5965ed8603d53'
)

configure()
{
    "../libdc1394-$version/configure" \
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
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libdc1394*so*; do
        $cmd_target_strip "$f" -o "$cfg_dir_rootfs/lib/$(basename "$f")"
    done
}
