version=\
(
    '1.6'
)

url=\
(
    "http://xcb.freedesktop.org/dist/xcb-proto-$version.tar.bz2"
)

md5=\
(
    '04313e1d914b44d0e457f6c494fc178b'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'python_host/host'
)

configure()
{
    "../xcb-proto-$version/configure" \
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
