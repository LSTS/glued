version=\
(
    '4.8.30'
)

url=\
(
    "http://download.oracle.com/berkeley-db/db-$version.tar.gz"
)

md5=\
(
    'f80022099c5742cd179343556179aa8c'
)

configure()
{
    mkdir -p ../build && cd ../build &&
    ../db-$version/dist/configure \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --enable-cxx \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical
}

build()
{
    $cmd_make -C ../build
}

host_install()
{
    $cmd_make -C ../build install
}

target_install()
{
    cp -a "$cfg_dir_toolchain_sysroot/usr/lib/"libdb*so $cfg_dir_rootfs/lib
    for f in "$cfg_dir_rootfs/lib/"libdb*so; do
        $cmd_target_strip "$f"
    done
}
