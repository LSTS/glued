version=\
(
    '9'
)

url=\
(
    "ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-$version.tar.bz2"
)

md5=\
(
    '29bd0fec976c1664a4abc83f1c7e57ed'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install &&
    ln -fs kmod "$cfg_dir_toolchain/sbin/depmod"
}
