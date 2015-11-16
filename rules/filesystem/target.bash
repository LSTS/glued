version=\
(
    "1.0"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

target_install()
{
    $cmd_mkdir \
        "$cfg_dir_rootfs"/{dev,boot,proc,sys,etc,bin,sbin,opt,var,mnt,root} \
        "$cfg_dir_rootfs"/usr/{bin,sbin,lib,lib/firmware} \
        "$cfg_dir_rootfs"/opt \
        "$cfg_dir_rootfs"/dev/{shm,pts} \
        "$cfg_dir_rootfs"/etc/rc.d

    ln -fs usr/lib "$cfg_dir_rootfs"/lib &&
    ln -fs dev/shm "$cfg_dir_rootfs"/tmp &&
    ln -fs ../tmp "$cfg_dir_rootfs"/var/tmp &&
    ln -fs ../tmp "$cfg_dir_rootfs"/var/run &&
    ln -fs ../tmp "$cfg_dir_rootfs"/var/log &&
    ln -fs ../tmp "$cfg_dir_rootfs"/var/lock &&
    ln -fs ../tmp "$cfg_dir_rootfs"/var/lib &&
    ln -fs /sbin/init "$cfg_dir_rootfs"/init &&
    ln -fs /tmp/resolv.conf "$cfg_dir_rootfs"/etc/resolv.conf &&
    ln -fs /proc/self/mounts "$cfg_dir_rootfs"/etc/mtab &&

    if [ -n "$cfg_target_lib64" ]; then
        ln -fs lib "$cfg_dir_rootfs/lib64"
    fi

    $cmd_mkdir "$cfg_dir_rootfs"/root/.ssh &&
    chmod 0700 "$cfg_dir_rootfs"/root/.ssh &&

    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -

    if [ -d "$cfg_dir_system/fs" ]; then
        tar -C "$cfg_dir_system/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
    fi
}
