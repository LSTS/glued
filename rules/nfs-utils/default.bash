version=\
(
    '1.3.1'
)

url=\
(
    "http://downloads.sourceforge.net/nfs/$version/nfs-utils-$version.tar.bz2"
)

md5=\
(
    '97f157f954edb6d4d4385a0c5986f36f'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libtirpc/default'
)

configure()
{
    "../nfs-utils-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_rootfs/usr" \
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
    $cmd_target_strip -v "utils/mount/mount.nfs" -o "$cfg_dir_rootfs/usr/bin/mount.nfs" &&
    ln -fs mount.nfs "$cfg_dir_rootfs/usr/bin/unmount.nfs" &&
    $cmd_target_strip -v "utils/exportfs/exportfs" -o "$cfg_dir_rootfs/usr/bin/exportfs" &&
    $cmd_target_strip -v "utils/mountd/mountd" -o "$cfg_dir_rootfs/usr/bin/rpc.mountd" &&
    $cmd_target_strip -v "utils/nfsd/nfsd" -o "$cfg_dir_rootfs/usr/bin/rpc.nfsd" &&
    $cmd_target_strip -v "utils/statd/statd" -o "$cfg_dir_rootfs/usr/bin/rpc.statd" &&
    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f  -
}
