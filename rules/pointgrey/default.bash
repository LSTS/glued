version=\
(
  "2.9.3.43"
)

url=\
(
  "https://www.dropbox.com/s/gtevdjnetc0ljtj/flycapture.$version_armhf.tar.gz"
)

md5=\
(
  "1bed9d34506a261eef30809b440566c7"
)

post_unpack()
{
    $cmd_cp -r "../flycapture.2.9.3.43_armhf/"* "../pointgrey-$version/"
    rm -r ../flycapture.2.9.3.43_armhf/
}

requires=\
(
    'libdc1394/default'
    'libusb/default'
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
    $cmd_cp -r "lib/"* "$cfg_dir_rootfs/usr/lib/"
}

