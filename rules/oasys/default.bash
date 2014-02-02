version=\
(
    '1.6.0'
)

url=\
(
    "http://downloads.sourceforge.net/dtn/oasys-$version.tgz"
)

md5=\
(
    'fc52baea5fd1db8bceb3031356c7acca'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../oasys-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --with-dbver=4.8 \
        --disable-static \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --with-tcl="$cfg_dir_toolchain_sysroot/usr" \
        --with-xerces-c="$cfg_dir_toolchain_sysroot/usr"
}

build()
{
    $cmd_make -j1
}

host_install()
{
    $cmd_make -j1 install
}

target_install()
{
    cp -a "$cfg_dir_toolchain_sysroot/usr/lib/"liboasys* $cfg_dir_rootfs/lib &&
    for f in "$cfg_dir_rootfs/lib/"liboasys*so; do
        $cmd_target_strip "$f"
    done
}
