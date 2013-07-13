version=\
(
    '3.3.2'
)

url=\
(
    "http://www.fftw.org/fftw-$version.tar.gz"
)

md5=\
(
    "6977ee770ed68c85698c7168ffa6e178"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    "../fftw-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
	--enable-single \
	--enable-neon
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
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libfftw3*.so*; do
        if [ -L "$f" ]; then
            cp -vd "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
}

