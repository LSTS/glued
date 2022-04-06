version=\
(
    '1.3.2'
)

url=\
(
    "http://downloads.sourceforge.net/nfs/$version/nfs-utils-$version.tar.bz2"
)

md5=\
(
    '1e2f3c1ed468dee02d00c534c002ea10'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libtirpc/rpi4'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches/$version"/*.patch)

    cd ../nfs-utils-$version
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    mkdir ../rootfs
    mkdir ../rootfs/etc
    mkdir ../rootfs/usr
    mkdir ../rootfs/usr/bin
    mkdir ../rootfs/usr/sbin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    "../nfs-utils-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_output_rootfs/usr" \
        --disable-gss \
        --disable-svcgss \
        --disable-ipv6 \
        --disable-tirpc \
        --disable-uuid \
        --disable-nfsv4 \
        --without-tcp-wrappers
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_target_strip -v "utils/mount/mount.nfs" -o "$cfg_dir_output_rootfs/usr/bin/mount.nfs" &&
    ln -fs mount.nfs "$cfg_dir_output_rootfs/usr/bin/unmount.nfs" &&
    $cmd_target_strip -v "utils/exportfs/exportfs" -o "$cfg_dir_output_rootfs/usr/bin/exportfs" &&
    $cmd_target_strip -v "utils/mountd/mountd" -o "$cfg_dir_output_rootfs/usr/bin/rpc.mountd" &&
    $cmd_target_strip -v "utils/nfsd/nfsd" -o "$cfg_dir_output_rootfs/usr/bin/rpc.nfsd" &&
    $cmd_target_strip -v "utils/statd/statd" -o "$cfg_dir_output_rootfs/usr/bin/rpc.statd" &&
    $cmd_target_strip -v "utils/statd/sm-notify" -o "$cfg_dir_output_rootfs/usr/sbin/sm-notify" &&
    touch "$cfg_dir_output_rootfs/etc/exports"

    tar -czf ../nfs-utils-v$version.tar.gz ../rootfs
}
