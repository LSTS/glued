version=\
(
    '3.1.0'
)

url=\
(
    "http://www.samba.org/ftp/rsync/rsync-$version.tar.gz"
)

md5=\
(
    '3be148772a33224771a8d4d2a028b132'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'zlib/default'
)

configure()
{
    ./configure \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_rootfs/usr" \
        --disable-ipv6 \
        --disable-locale \
        --disable-debug \
        --disable-iconv \
        --disable-acl-support \
        --disable-xattr-support \
        --with-included-popt
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_target_strip rsync -o "$cfg_dir_rootfs/usr/bin/rsync" &&
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
