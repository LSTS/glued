version=\
(
    '1.8.0_51'
)

url=\
(
    "https://github.com/zepinto/glued_pkg/raw/master/ejre_armhf_$version.tar.bz2"
)

md5=\
(
    'c1619ad3fe3c069cbb09064711f4f9e4'
)

target_install()
{
    $cmd_mkdir "$cfg_dir_rootfs/usr/share/java" &&
    $cmd_cp "../ejre$version/"* "$cfg_dir_rootfs/usr/share/java" &&
    ln -rs "$cfg_dir_rootfs/usr/share/java/bin/java" "$cfg_dir_rootfs/usr/bin/java"
}
