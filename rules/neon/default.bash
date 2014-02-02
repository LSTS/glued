version=\
(
    '0.29.5'
)

url=\
(
    "http://www.webdav.org/neon/neon-$version.tar.gz"
)

md5=\
(
    'ff369e69ef0f0143beb5626164e87ae2'
)

requires=\
(
    'gnutls/default'
)

configure()
{
    "../neon-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared \
        --with-ssl=gnutls \
        --without-libproxy
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
