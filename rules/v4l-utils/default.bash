version=\
(
    1.20.0
)

url=\
(
    http://www.linuxtv.org/downloads/v4l-utils/v4l-utils-$version.tar.bz2
)

md5=\
(
    46f9e2c0b2fdccd009da2f7e1aa87894
)

configure()
{
    export PATH=$cfg_dir_toolchain/bin:$PATH
    export INSTALL_PREFIX=$cfg_dir_toolchain_sysroot
    ./configure \
        --prefix="$cfg_dir_rootfs/usr" \
        --host="$cfg_target_canonical" \
        --without-jpeg
}

build()
{
    $cmd_make \
        CC=$cmd_target_cc \
        CXX=$cmd_target_cxx \
        -C lib
}

host_install()
{
    $cmd_make_single \
        CC=$cmd_target_cc \
        CXX=$cmd_target_cxx \
        PREFIX="$cfg_dir_toolchain_sysroot/usr" \
        -C lib \
        install
}

target_install()
{
    for f in "$cfg_dir_rootfs/usr/lib/"libv4l*so*; do
        $cmd_target_strip "$f" -o "$cfg_dir_toolchain_sysroot/usr/lib/$(basename "$f")"
    done

    $cmd_mkdir "$cfg_dir_toolchain_sysroot/usr/lib/libv4l"
    for f in "$cfg_dir_rootfs/usr/lib/libv4l/"*; do
        $cmd_target_strip "$f" -o "$cfg_dir_toolchain_sysroot/usr/lib/libv4l/$(basename "$f")"
    done
}
