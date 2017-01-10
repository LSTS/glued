version=\
(
    '2016-05-17'
)

url=\
(
    "https://github.com/rasmartins/rpi-boot-firmware/archive/rpi-boot-firmware-$version.tar.gz"
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

md5=\
(
    '0f2591003dc1cf6b5550a28e56d06f40'
)

target_install()
{
    $cmd_mkdir \
        "$cfg_dir_rootfs/boot" &&

    for f in bootcode.bin fixup.dat start.elf; do
        $cmd_cp -r "../$pkg-$pkg-$version/$f" "$cfg_dir_rootfs/boot"
    done &&

    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
