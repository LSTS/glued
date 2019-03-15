version=\
(
    '2019-02-25'
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
    'da98308e12fa1eec23a1213d66cde30d'
)

target_install()
{
    $cmd_mkdir "$cfg_dir_rootfs/boot"

    $cmd_cp "../$pkg-$version/"* "$cfg_dir_rootfs/boot/"

    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
