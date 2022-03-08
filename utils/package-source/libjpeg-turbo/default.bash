version=\
(
    '1.2.0'
)

url=\
(
    "http://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-$version.tar.gz"
)

md5=\
(
    '5329fa80953938cb4f097afae55059e2'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'nasm/host'
)

configure()
{
    "../libjpeg-turbo-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared \
        --with-jpeg8 \
        --with-simd
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
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"{libjpeg*so*,libturbojpeg*so*}; do
        if [ -L "$f" ]; then
            cp -vd "$f" "$cfg_dir_rootfs/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/lib/$(basename "$f")"
        fi
    done
}
