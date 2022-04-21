version=\
(
    'v3.82'
)

requires=\
(
    'nasm/host-atom'
    'python_host/host-atom'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/syslinux-$version.tar.gz"
)

md5=\
(
    'ca73d913e09e771390e514494aef0a50'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}

postconfigure()
{
    rm -rf $cfg_dir_builds/$pkg/toolchain
    rm -rf $cfg_dir_builds/$pkg/rootfs
    rm -rf $cfg_dir_builds/$pkg/syslinux-$version
    rm -rf $cfg_dir_builds/$pkg/.download
    rm -rf $cfg_dir_builds/$pkg/.post_unpack
    rm -rf $cfg_dir_builds/$pkg/.unpack
}
