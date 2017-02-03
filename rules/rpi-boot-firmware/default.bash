version=\
(
    '2017-02-02'
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
    'eb42664fce4d73f167064e697dfacb76'
)

target_install()
{
    $cmd_mkdir "$cfg_dir_rootfs/boot"

    $cmd_cp "../$pkg-$version/"* "$cfg_dir_rootfs/boot/"

    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
