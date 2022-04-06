version=\
(
    '7.1p1'
)

url=\
(
    "http://ftp5.usa.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-$version.tar.gz"
)

md5=\
(
    '8709736bc8a8c253bc4eeb4829888ca5'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

requires=\
(
    'openssl/default'
)

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --with-privsep-path=$cfg_dir_rootfs/var/empty \
        --disable-strip
        
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install-files
}

target_install()
{
    $cmd_mkdir "$cfg_dir_rootfs/bin" &&
    for f in scp sftp slogin ssh ssh-add ssh-agent ssh-keygen ssh-keyscan; do
        $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/$f" "$cfg_dir_rootfs/bin/$f"
    done &&

    $cmd_mkdir "$cfg_dir_rootfs/libexec" &&
    for f in sftp-server ssh-keysign ssh-pkcs11-helper; do
        $cmd_cp "$cfg_dir_toolchain_sysroot/usr/libexec/$f" "$cfg_dir_rootfs/libexec/$f"
    done &&

    $cmd_mkdir "$cfg_dir_rootfs/sbin" &&
    for f in sshd; do
        $cmd_cp "$cfg_dir_toolchain_sysroot/usr/sbin/$f" "$cfg_dir_rootfs/sbin/$f"
    done
}
