version=\
(
    '1.4.0'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/libX11-$version.tar.bz2"
)

md5=\
(
    'b63d9f7493a61df51d0c0be04ac435e4'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'xorg-inputproto/default'
    'xorg-kbproto/default'
    'xorg-xproto/default'
    'xorg-xextproto/default'
    'xorg-libxcb/default'
    'xorg-xtrans/default'
)

post_unpack()
{
    (echo -e "#ifndef _GNU_SOURCE\n#define _GNU_SOURCE\n#endif" && cat ../libX11-$version/src/util/makekeys.c) > ../libX11-$version/src/util/makekeys.c.new && \
	mv ../libX11-$version/src/util/makekeys.c.new ../libX11-$version/src/util/makekeys.c
}

configure()
{
    "../libX11-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libX11.so*; do
        dst="$cfg_dir_rootfs/lib/$(basename "$f")"
        cp -v -a "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done
}
