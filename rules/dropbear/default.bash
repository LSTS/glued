version=\
(
    '2012.55'
)

url=\
(
    "https://matt.ucc.asn.au/dropbear/releases/dropbear-$version.tar.bz2"
)

md5=\
(
    '8c784baec3054cdb1bb4bfa792c87812'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'zlib/default'
)

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    "../dropbear-$version/configure" \
        --prefix="$cfg_dir_rootfs/usr" \
        --disable-utmp \
        --disable-utmpx \
        --disable-wtmp \
        --disable-wtmpx \
        --disable-lastlog \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --with-zlib="$cfg_dir_toolchain"
}

build()
{
    $cmd_make \
        PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" \
        MULTI=1
}

target_install()
{
    $cmd_target_strip dropbearmulti -o "$cfg_dir_rootfs/usr/bin/dropbearmulti" &&
    ln -fs dropbearmulti "$cfg_dir_rootfs/usr/bin/dropbearconvert" &&
    ln -fs dropbearmulti "$cfg_dir_rootfs/usr/bin/dropbearkey" &&
    ln -fs dropbearmulti "$cfg_dir_rootfs/usr/bin/scp" &&
    ln -fs dropbearmulti "$cfg_dir_rootfs/usr/bin/ssh" &&
    ln -fs dropbearmulti "$cfg_dir_rootfs/usr/bin/dbclient" &&
    ln -fs ../bin/dropbearmulti "$cfg_dir_rootfs/usr/sbin/dropbear" &&
    tar -C "$cfg_package_spec_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
