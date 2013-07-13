version=\
(
    '2.0.1'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/inputproto-$version.tar.bz2"
)

md5=\
(
    'da9bf9e5d174163f597d2d72757d9038'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../inputproto-$version/configure" \
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
