version=\
(
    '1.4.31'
)

revision=\
(
    '1'
)

url=\
(
    "http://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-$version.tar.bz2"
)

md5=\
(
    'c718cc27658240d307b8a1d1c7c4bb54'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    export LUA_CFLAGS=-I"$cfg_dir_toolchain_sysroot/usr/include"
    export LUA_LIBS=-I"$cfg_dir_toolchain_sysroot/usr/lib"
    "../lighttpd-$version/configure" \
        --prefix="/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --without-bzip2 \
        --with-lua
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_mkdir \
        "$cfg_dir_rootfs/usr/sbin" &&

    $cmd_mkdir \
        "$cfg_dir_rootfs/usr/lib" &&

    for f in src/.libs/*.so; do
        $cmd_target_strip \
            --strip-unneeded \
            "$f" \
            -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    done &&

    $cmd_target_strip \
        --strip-unneeded \
        src/lighttpd \
        -o "$cfg_dir_rootfs/usr/sbin/lighttpd" &&

    $cmd_target_strip \
        --strip-unneeded \
        src/lighttpd-angel \
        -o "$cfg_dir_rootfs/usr/sbin/lighttpd-angel"
}
