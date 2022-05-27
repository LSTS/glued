version=\
(
    '4.9.y'
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
    '54882192121f58d12bdda57d7014dc49'
)

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/boot
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs
    $cmd_cp "../$pkg-$version/"* "$cfg_dir_output_rootfs/boot/"
    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_output_rootfs" -x -v -f -
    tar -czf ../rpi-boot-firmware-v$version.tar.gz ../rootfs
}
