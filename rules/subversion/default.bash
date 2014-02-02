version=\
(
    '1.6.15'
)

url=\
(
    "http://subversion.tigris.org/downloads/subversion-$version.tar.bz2"
    "http://www.sqlite.org/sqlite-amalgamation-3.6.13.tar.gz"
)

md5=\
(
    '113fca1d9e4aa389d7dc2b210010fa69'
    '681722e7cdc6d9ab3be836736ed50641'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'neon/default'
    'zlib/default'
    'apr/default'
    'apr-utils/default'
)

post_unpack()
{
    mkdir sqlite-amalgamation &&
    cp ../sqlite-3.6.13/sqlite3.{c,h} sqlite-amalgamation
}

configure()
{
    "../subversion-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --without-apxs \
        --with-neon="$cfg_dir_toolchain_sysroot/usr" \
        --with-zlib="$cfg_dir_toolchain_sysroot/usr" \
        --with-apr="$cfg_dir_toolchain_sysroot/usr" \
        --with-apr-util="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make -j1 install
}
