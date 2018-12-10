version=\
(
    '2.3.2'
)

url=\
(
    "http://download.osgeo.org/gdal/2.3.2/gdal-2.3.2.tar.gz"
)

md5=\
(
    '221e4bfe3e8e9443fd33f8fe46f8bf60'
)

maintainer=\
(
    'Tiago Sá Marques <tsmarques@lsts.pt>'
)

configure()
{
    "./configure" \
        --prefix="$cfg_dir_toolchain" \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --with-build-sysroot="$cfg_dir_toolchain_sysroot" \
        --with-sysroot="$cfg_dir_toolchain_sysroot"
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
    cp -a "$cfg_dir_toolchain/lib/"libgdal*so* $cfg_dir_rootfs/lib
    for f in "$cfg_dir_rootfs/lib/"libgdal*so; do
        $cmd_target_strip "$f"
    done
}
