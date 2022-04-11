version=\
(
    '2015.67'
)

url=\
(
    "https://matt.ucc.asn.au/dropbear/releases/dropbear-$version.tar.bz2"
)

md5=\
(
    'e967e320344cd4bfebe321e3ab8514d6'
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
    patches=$(ls "$pkg_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/usr
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/bin
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/sbin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    "../dropbear-$version/configure" \
        --prefix="$cfg_dir_output_rootfs/usr" \
        --disable-utmp \
        --disable-utmpx \
        --disable-wtmp \
        --disable-wtmpx \
        --disable-lastlog \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --with-zlib="$cfg_dir_toolchain_sysroot/usr"
}

build()
{
    $cmd_make \
        PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" \
        MULTI=1
}

target_install()
{
    $cmd_target_strip dropbearmulti -o "$cfg_dir_output_rootfs/usr/bin/dropbearmulti" &&
    ln -fs dropbearmulti "$cfg_dir_output_rootfs/usr/bin/dropbearconvert" &&
    ln -fs dropbearmulti "$cfg_dir_output_rootfs/usr/bin/dropbearkey" &&
    ln -fs dropbearmulti "$cfg_dir_output_rootfs/usr/bin/scp" &&
    ln -fs dropbearmulti "$cfg_dir_output_rootfs/usr/bin/ssh" &&
    ln -fs dropbearmulti "$cfg_dir_output_rootfs/usr/bin/dbclient" &&
    ln -fs ../bin/dropbearmulti "$cfg_dir_output_rootfs/usr/sbin/dropbear" &&
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_output_rootfs" -x -v -f -

    tar -czf ../dropbear-v$version.tar.gz ../rootfs
}
