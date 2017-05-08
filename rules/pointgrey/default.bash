version=\
(
    "2.9.3.43"
)

url=\
(
    "http://lsts.pt/glued/flycapture.$version.armhf.tar.gz"
)

md5=\
(
    "65ab561add3cb94f15d580563812c597"
)

post_unpack()
{
    $cmd_cp -r "../flycapture.2.9.3.43_armhf/"* "../pointgrey-$version/"
    rm -r ../flycapture.2.9.3.43_armhf/
}

requires=\
(
    'libusb/default'
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

