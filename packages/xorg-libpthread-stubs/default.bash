version=\
(
    '0.3'
)

url=\
(
    "http://xcb.freedesktop.org/dist/libpthread-stubs-$version.tar.bz2"
)

md5=\
(
    'e8fa31b42e13f87e8f5a7a2b731db7ee'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../libpthread-stubs-$version/configure" \
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
    $cmd_make install
}
