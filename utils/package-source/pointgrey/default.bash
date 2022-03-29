version=\
(
    "2.11.3.121"
)

url=\
(
    "https://www.lsts.pt/glued/validPackages/flycapture.$version.armhf.tar.gz"
)

md5=\
(
    "788861351143e3279cf4522e1055e739"
)

post_unpack()
{
    $cmd_cp -r "../flycapture.2.11.3.121_armhf/"* "../pointgrey-$version/"
    rm -r ../flycapture.2.11.3.121_armhf/
}

requires=\
(
    'libusb/rpi4'
    'libraw1394/rpi4'
    'libdc1394/rpi4'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

host_install()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/lib
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/include
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    $cmd_cp -r "lib/"*    "$cfg_dir_output_toolchain_sysroot/usr/lib/"
    $cmd_cp -r "include/"* "$cfg_dir_output_toolchain_sysroot/usr/include/"
}

target_install()
{
    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/usr
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/lib
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/include
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_cp -r "lib/"* "$cfg_dir_output_rootfs/usr/lib/"
    $cmd_cp -r "include/"* "$cfg_dir_output_rootfs/usr/include/"

    tar -czf ../pointgrey-v$version.tar.gz ../rootfs ../toolchain
}
