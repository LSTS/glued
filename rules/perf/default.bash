version=\
(
    "3.19"
)

url=\
(
       "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$version.tar.xz"
)

requires=\
(
    'flex/host'
    'bison/host'
    'zlib/default'
)

# v3.19
md5=\
(
       'd3fc8316d4d4d04b65cbc2d70799e763'
)

#3.14.63
# md5=('6cf8a6b23849f47f511e0e46cfdb6392')

build()
{
    
    cd ../linux-$version/
    $cmd_make \
	CROSS_COMPILE="$cfg_target_canonical-" \
	ARCH="$cfg_target_linux" \
	INSTALL_MOD_PATH="$cfg_dir_rootfs/usr" \
	KBUILD_VERBOSE=1 \
	DEPMOD="$cfg_dir_toolchain/sbin/depmod" \
	NO_LIBELF=1 \
	LDFLAGS=-static \
	-C "./tools/perf/"
}

target_install()
{
    $cmd_cp ../linux-$version/tools/perf/perf \
	    $cfg_dir_rootfs/usr/bin/
}
