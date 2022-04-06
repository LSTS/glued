version=\
(
    '1.1.0'
)

url=\
(
    "http://www.lsts.pt/glued/coreboot-lsts-$version.tar.gz"
)

md5=\
(
    'a7c77a981778bec54f28f598814f11c6'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

target_install()
{
    dir="$cfg_dir_rootfs/usr/share/coreboot-lsts"
    $cmd_mkdir "$dir" &&
    $cmd_cp "coreboot-lsts-$version.rom" "$dir"
}
