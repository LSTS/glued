version=\
(
    '1.0.7'
)

url=\
(
    "http://www.lsts.pt/glued/escc-$version.tar.gz"
)

md5=\
(
    '4e18a516249256e2dad4d79ae56c913d'
)

if [ -d "$cfg_dir_builds/linux/linux-"* ]; then
    kernel="$(echo $cfg_dir_builds/linux/linux-*)"
fi

build()
{
    $cmd_make \
        ARCH=$cfg_target_linux \
        CROSS_COMPILE=$cfg_target_canonical- \
        M=`pwd` \
        -C "$kernel" &&

    for util in setescc esccclock esccsettings esccfs6131; do
        make CC="$cmd_target_cc" -C "utils/$util"
    done
}

target_install()
{
    $cmd_make \
        ARCH=$cfg_target_linux \
        CROSS_COMPILE=$cfg_target_canonical- \
        M=`pwd` \
        INSTALL_MOD_PATH=$cfg_dir_rootfs \
        -C "$kernel" \
        modules_install &&

    for util in setescc esccclock esccsettings esccfs6131; do
        $cmd_target_strip "utils/$util/$util" -o "$cfg_dir_rootfs/usr/bin/$util"
    done &&

    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
