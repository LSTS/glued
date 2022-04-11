version=\
(
    '2.2.0'
)

url=\
(
    "http://downloads.sourceforge.net/ptpd/ptpd-$version.tar.gz"
)

md5=\
(
    'c63a3a149d30c710773ccb02df5782a3'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    make CC="$cmd_target_cc" -C src
}

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/bin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_target_strip src/ptpd2 -o $cfg_dir_output_rootfs/usr/bin/ptpd2 &&
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_output_rootfs" -x -v -f -

    tar -czf ../ptpd-v$version.tar.gz ../rootfs
}
