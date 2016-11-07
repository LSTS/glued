version=\
(
  "2.10.3.237"
)

url=\
(
  "https://www.dropbox.com/s/ediz2btaaq6a8sc/flycapture.$version_armhf.tar.gz"
)

md5=\
(
  "ffee545c0353f1a31008ad3166b1f057"
)

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
  $cmd_cp -r "../flycapture.2.10.3.237_armhf/lib/"*    "$cfg_dir_toolchain_sysroot/usr/lib/"
  $cmd_cp -r "../flycapture.2.10.3.237_armhf/include/"* "$cfg_dir_toolchain_sysroot/usr/include/"
}

target_install()
{
    $cmd_cp -r "../flycapture.2.10.3.237_armhf/lib/"* "$cfg_dir_rootfs/usr/lib/"
}

