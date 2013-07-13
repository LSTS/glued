version=\
(
    "0.9.5.2"
)

url=\
(
    "http://download.flashrom.org/releases/flashrom-$version.tar.bz2"
)

md5=\
(
    "280f8b1d3ef0533d6ec913b0da857477"
)

maintainer=\
(
    "Renato Caldas <rmsc@fe.up.pt>"
)

build()
{
    echo $cmd_make &&
    $cmd_make \
	PREFIX="$cfg_dir_toolchain_sysroot/usr" \
	CC="$cmd_target_cc" \
	STRIP="$cmd_target_strip" \
	AR="$cmd_target_ar" \
	RANLIB="$cmd_target_ranlib" \
	CONFIG_RAYER_SPI=no \
	CONFIG_NIC3COM=no \
	CONFIG_GFXNVIDIA=no \
	CONFIG_SATASII=no \
	CONFIG_FT2232_SPI=no \
	CONFIG_DUMMY=no \
	CONFIG_DRKAISER=no \
	CONFIG_NICREALTEK=no
}

target_install()
{
    $cmd_target_strip flashrom
    cp flashrom "$cfg_dir_rootfs/usr/sbin"
}
