version=\
(
    '1.0.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

requires=\
(
    'bash/default'
)

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/bin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs
    cp -rf "$pkg_dir/fs/usr" "$cfg_dir_output_rootfs"
    tar -czf ../glued-apk-v$version.tar.gz ../rootfs
}