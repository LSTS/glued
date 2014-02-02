version=\
(
    '2.9.2'
)

url=\
(
    "http://ftp.gnome.org/pub/gnome/sources/atk/2.9/atk-$version.tar.xz"
)

md5=\
(
    'd6de35003815569508bf0a4e3ed598f4'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"

    "../atk-$version/configure" \
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
