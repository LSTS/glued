version=\
(
    'v2_2_3'
)

url=\
(
    "http://downloads.sourceforge.net/muparser/muparser_$version.zip"
)

md5=\
(
    '9de40ec1dab5bd2787ee344fce5846ad'
)

configure()
{
    # Unzip has some issue:
    ../muparser_$version/configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --enable-shared \
        --enable-samples=no
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install

    # One step is missing:
    $cmd_mkdir "${cfg_dir_toolchain_sysroot}/usr/include/muParser"
    mv -v ${cfg_dir_toolchain_sysroot}/usr/include/muParser*.* ${cfg_dir_toolchain_sysroot}/usr/include/muParser
}

target_install()
{
    for f in "${cfg_dir_toolchain_sysroot}/usr/lib/"libmuparser.so*; do
        $cmd_target_strip "$f" -o "${cfg_dir_rootfs}/lib/$(basename "$f")"
    done
}
