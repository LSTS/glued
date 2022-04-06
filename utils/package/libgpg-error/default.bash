version=\
(
    '1.10'
)

url=\
(
    "ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-$version.tar.bz2"
)

md5=\
(
    '736a03daa9dc5873047d4eb4a9c22a16'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../libgpg-error-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install &&
    cp src/gpg-error-config "$cfg_dir_toolchain/bin"
}

target_install()
{
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libgpg-error*.so*; do
        if [ -L "$f" ]; then
            cp -vd "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
}
