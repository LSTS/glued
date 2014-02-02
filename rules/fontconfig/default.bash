version=\
(
    '2.10.93'
)

url=\
(
    "http://www.freedesktop.org/software/fontconfig/release/fontconfig-$version.tar.bz2"
)

md5=\
(
    '0f8e5c63c2d6931626185c02802375a3'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'expat/default'
)

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"

    "../fontconfig-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
