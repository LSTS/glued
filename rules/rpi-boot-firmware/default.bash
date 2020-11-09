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
    $cmd_mkdir "$cfg_dir_rootfs/boot"

    $cmd_cp "../$pkg-$version/"* "$cfg_dir_rootfs/boot/"

    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
