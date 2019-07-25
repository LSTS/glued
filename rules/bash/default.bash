version=\
(
    "4.4.18"
)

url=\
(
    "http://ftp.gnu.org/gnu/bash/bash-$version.tar.gz"
)

md5=\
(
    '518e2c187cc11a17040f0915dddce54e'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@fe.up.pt>'
)


configure()
{
    ./configure \
    --prefix=${cfg_dir_rootfs}/usr \
    --host=${cfg_target_canonical} \
    --bindir=${cfg_dir_toolchain}/bin \
    --without-bash-malloc
}

build()
{
    $cmd_make VERBOSE=1
}

host_install()
{
    $cmd_make install
}

target_install()
{
    $cmd_cp bash ${cfg_dir_rootfs}/usr/bin
    $cmd_cp bashversion ${cfg_dir_rootfs}/usr/bin
}
