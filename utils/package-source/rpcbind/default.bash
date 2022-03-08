version=\
(
    '0.2.2'
)

url=\
(
    "http://downloads.sourceforge.net/rpcbind/rpcbind-$version.tar.bz2"
)

md5=\
(
    '8acf839bfef2364a05fbd6be5f8edf9a'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libtirpc/default'
)

post_unpack()
{
    sed -i "/servname/s:rpcbind:sunrpc:" src/rpcbind.c &&
        sed -i "/error = getaddrinfo/s:rpcbind:sunrpc:" src/rpcinfo.c
}

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"

    "../rpcbind-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --with-rpcuser=root \
        --without-systemdsystemunitdir
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
    $cmd_mkdir "$cfg_dir_rootfs/usr/bin"

    for f in rpcbind rpcinfo; do
        $cmd_target_strip "$f" -o "$cfg_dir_rootfs/usr/bin/$f"
    done
}
