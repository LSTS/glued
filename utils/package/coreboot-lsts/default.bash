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
    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/usr
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/share
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    dir="$cfg_dir_output_rootfs/usr/share/coreboot-lsts"
    $cmd_mkdir "$dir" &&
    $cmd_cp "coreboot-lsts-$version.rom" "$dir"

    tar -czf ../coreboot-lsts-v$version.tar.gz ../rootfs
}
