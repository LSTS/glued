version=\
(
    '1.0.71'
)

url=\
(
    "http://www.lsts.pt/glued/escc-$version.tar.gz"
)

md5=\
(
    '075c9256fe20cf6ce867dc2b1c974ebe'
)

build()
{
    #echo "$cfg_dir_builds/linux/linux-*"
    #if [ -d "$cfg_dir_builds/linux/linux-"* ]; then
    #    kernel="$(echo $cfg_dir_builds/linux/linux-*)"
    #fi
    ### NOTE
    # To compile this rule the linux source build must be present/compiled.    
    kernel="$(echo $cfg_dir_builds/linux/linux-*)"

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
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/bin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs
    $cmd_make \
        ARCH=$cfg_target_linux \
        CROSS_COMPILE=$cfg_target_canonical- \
        M=`pwd` \
        INSTALL_MOD_PATH=$cfg_dir_output_rootfs \
        -C "$kernel" \
        modules_install &&

    for util in setescc esccclock esccsettings esccfs6131; do
        $cmd_target_strip "utils/$util/$util" -o "$cfg_dir_output_rootfs/usr/bin/$util"
    done &&

    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_output_rootfs" -x -v -f -
    tar -czf ../escc-v$version.tar.gz ../rootfs
}
