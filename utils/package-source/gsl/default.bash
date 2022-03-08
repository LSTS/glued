version=\
(
    '1.15'
)

url=\
(
    "ftp://ftp.gnu.org/gnu/gsl/gsl-$version.tar.gz"
)

md5=\
(
    '494ffefd90eef4ada678c306bab4030b'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    ./configure \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
	--prefix="$cfg_dir_toolchain_sysroot/usr" \
        --enable-shared \
        --enable-static
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
    base="$cfg_dir_toolchain_sysroot/usr/lib"

    for f in $base/libgslcblas.so* $base/libgsl.so*; do
        dst="$cfg_dir_rootfs/lib/$(basename "$f")"
        cp -v -d "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done
}
