version=\
(
    '2020-12-01'
)

url=\
(
    "http://lsts.pt/glued/rpi-boot-firmware-$version.zip"
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
    'Pedro Gonçalves <pedro@lsts.pt>'
)

md5=\
(
    'f58304d09266b8e470349ada91a41340'
)

target_install()
{
#    eval "apt-get update; apt-get install -y libssl-dev bison kmod bc flex"
    mkdir -p $cfg_dir_builds/$pkg/rootfs/boot
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs
    $cmd_cp "../$pkg-$version/"* "$cfg_dir_output_rootfs/boot/"
    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_output_rootfs" -x -v -f -
    tar -czf ../rpi-boot-firmware-v$version.tar.gz ../rootfs
}