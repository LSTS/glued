version=\
(
    '1.9.3'
)

url=\
(
    "http://www.lsts.pt/glued/apache-ant-$version-bin.tar.bz2"
)

md5=\
(
    '6e6d888140858f3926c34081c4bd2227'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

host_install()
{

    mkdir $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    cp -a ../apache-ant-$version/lib $cfg_dir_output_toolchain &&
    cp -a ../apache-ant-$version/etc $cfg_dir_output_toolchain &&
    cp -a ../apache-ant-$version/bin $cfg_dir_output_toolchain

    tar -czf ../apache-ant-v$version.tar.gz ../toolchain
}
