version=\
(
    '2018-08-17'
)

url=\
(
    "http://www.lsts.pt/glued/rpi-boot-firmware-$version.zip"
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
    'Pedro Gonçalves <pedro@lsts.pt>'
)

md5=\
(
    '2b06b9704616ee2a66829281bd480ff3'
)

target_install()
{
    $cmd_mkdir "$cfg_dir_rootfs/boot"

    $cmd_cp "../$pkg-$version/"* "$cfg_dir_rootfs/boot/"

    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
