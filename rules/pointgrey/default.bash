version=\
(
    "2.11.3.121"
)

url=\
(
    "http://lsts.pt/glued/flycapture.$version.armhf.tar.gz"
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
    'libusb/default'
    'libraw1394/default'
    'libdc1394/default'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

host_install()
{
    $cmd_cp -r "lib/"*    "$cfg_dir_toolchain_sysroot/usr/lib/"
    $cmd_cp -r "include/"* "$cfg_dir_toolchain_sysroot/usr/include/"
}

target_install()
{
    $cmd_mkdir "$cfg_dir_rootfs/usr/include/"
    $cmd_cp -r "lib/"* "$cfg_dir_rootfs/usr/lib/"
    $cmd_cp -r "include/"* "$cfg_dir_rootfs/usr/include/"
}
