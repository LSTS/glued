version=\
(
    '7.1.2'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/xextproto-$version.tar.bz2"
)

md5=\
(
    '263ae968b223c23b2986603d84e5c30e'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../xextproto-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared \
	--without-xmlto
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
