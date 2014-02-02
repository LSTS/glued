version=\
(
    0.8.8
)

url=\
(
    http://www.linuxtv.org/downloads/v4l-utils/v4l-utils-$version.tar.bz2
)

md5=\
(
    40fdda3f4055ed818012d7a7b5ef5be5
)

build()
{
    $cmd_make \
        CC=$cmd_target_cc \
        CXX=$cmd_target_cxx \
        -C lib
}

host_install()
{
    $cmd_make \
        CC=$cmd_target_cc \
        CXX=$cmd_target_cxx \
        PREFIX="$cfg_dir_toolchain_sysroot/usr" \
        -C lib \
        install
}

target_install()
{
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libv4l*so*; do
        $cmd_target_strip "$f" -o "$cfg_dir_rootfs/lib/$(basename "$f")"
    done

    $cmd_mkdir "$cfg_dir_rootfs/lib/libv4l"
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/libv4l/"*; do
        $cmd_target_strip "$f" -o "$cfg_dir_rootfs/lib/libv4l/$(basename "$f")"
    done
}
