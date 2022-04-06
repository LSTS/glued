version=\
(
    '1.11.0'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/util-macros-$version.tar.bz2"
)

md5=\
(
    '22d5cdff672450cb6902e0d68c200dcb'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../util-macros-$version/configure" \
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
