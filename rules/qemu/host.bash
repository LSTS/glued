version=\
(
    '1.2.0'
)

url=\
(
    "http://wiki.qemu.org/download/qemu-$version.tar.bz2"
)

md5=\
(
    '78eb1e984f4532aa9f2bdd3c127b5b61'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'glib/host'
)

configure()
{
    "../qemu-$version/configure" \
        --prefix="$cfg_dir_toolchain" \
        --disable-docs \
        --disable-system \
        --disable-kvm \
        --disable-bluez \
        --disable-curses \
        --extra-cflags="-I$cfg_dir_toolchain/include" \
        --extra-ldflags="-L$cfg_dir_toolchain/lib"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
