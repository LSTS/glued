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

    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/usr
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/bin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs/usr

    ./configure \
    --prefix=${cfg_dir_output_rootfs} \
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
    $cmd_cp bash ${cfg_dir_output_rootfs}/bin
    $cmd_cp bashversion ${cfg_dir_output_rootfs}/bin

    tar -czf ../bash-v$version.tar.gz ../rootfs
}
