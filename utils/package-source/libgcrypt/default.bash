version=\
(
    '1.5.0'
)

url=\
(
    "ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-$version.tar.bz2"
)

md5=\
(
    '693f9c64d50c908bc4d6e01da3ff76d8'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libgpg-error/default'
)

configure()
{
    "../libgcrypt-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-asm \
        --disable-static \
        --enable-shared
}

build()
{
    $cmd_make -j1
}

host_install()
{
    $cmd_make install
}

target_install()
{
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libgcrypt*.so*; do
        if [ -L "$f" ]; then
            cp -vd "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
}
