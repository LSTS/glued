version=29
url=(http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/wireless_tools.$version.tar.gz)
md5=(e06c222e186f7cc013fd272d023710cb)
build_dir=wireless_tools.$version

build()
{
    $cmd_make \
        CC="$cmd_target_cc" \
        AR="$cmd_target_ar" \
        RANLIB="$cmd_target_ranlib" \
        BUILD_STRIPPING="y" \
        BUILD_STATIC="y" \
        iwmulticall
}

target_install()
{
    install -m 755 iwmulticall $cfg_dir_rootfs/usr/bin/iwconfig &&
    ln -f -s iwconfig $cfg_dir_rootfs/usr/bin/iwlist &&
    ln -f -s iwconfig $cfg_dir_rootfs/usr/bin/iwspy &&
    ln -f -s iwconfig $cfg_dir_rootfs/usr/bin/iwpriv &&
    ln -f -s iwconfig $cfg_dir_rootfs/usr/bin/iwgetid
}
