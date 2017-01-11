version=\
(
    '2016-10-20'
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
    'a5310b72332031e617518f321bf3c61e'
)

target_install()
{
    $cmd_mkdir \
        "$cfg_dir_rootfs/boot" &&

    for f in bootcode.bin fixup.dat start.elf start_cd.elf start_db.elf start_x.elf; do
        $cmd_cp -r "../$pkg-$version/$f" "$cfg_dir_rootfs/boot"
    done &&

    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
