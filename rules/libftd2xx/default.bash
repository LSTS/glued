version=\
(
    '1.3.6'
)

url=\
(
    "http://www.ftdichip.com/Drivers/D2XX/Linux/libftd2xx-arm-v7-hf-1.3.6.tgz"
)

md5=\
(
    '8310dc499386dc5151c035222883e6fc'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

host_install()
{
    $cmd_cp \
        ../release/{ftd2xx.h,WinTypes.h} \
        "$cfg_dir_toolchain_sysroot/usr/include" &&
    $cmd_cp \
        ../release/build/libftd2xx.* \
        "$cfg_dir_toolchain_sysroot/usr/lib"
}

target_install()
{
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/libftd2xx"*so*; do
        $cmd_target_strip "$f" -o "$cfg_dir_rootfs/lib/$(basename "$f")"
    done
}
