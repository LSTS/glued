version=\
(
    '0.4.0-rc1'
)

url=\
(
    "http://www.lsts.pt/glued/trex-$version-Linux.tar.gz"
)

md5=\
(
    '9de8dcc4d7e6053100c5de2b29a5362c'
)

maintainer=\
(
    'José Pinto <zepinto@fe.up.pt>'
)

target_install()
{

    rm -rf "$cfg_dir_rootfs/opt/lsts/trex"
    $cmd_mkdir "$cfg_dir_rootfs/opt/lsts" &&
    cp -rav "../trex-$version-Linux/shared/trex" "$cfg_dir_rootfs/opt/lsts" &&

    $cmd_mkdir "$cfg_dir_rootfs/opt/lsts/trex/lib"

    base="../trex-$version-Linux/lib"
    for f in "$base/"*.so*; do
        dst="$cfg_dir_rootfs/opt/lsts/trex/lib/$(basename "$f")"
        cp -v -d "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done &&

    $cmd_mkdir "$cfg_dir_rootfs/opt/lsts/trex/bin"

    for f in "../trex-$version-Linux/bin/"*; do
        dst="$cfg_dir_rootfs/opt/lsts/trex/bin/$(basename "$f")"
        cp -v -d "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done &&

    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
