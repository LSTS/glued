version=\
(
    '2015-06-03'
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
    'a80ee36b66cccda4e9ccb7eb26bd6bb8'
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
