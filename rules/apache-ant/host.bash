version=\
(
    '1.9.3'
)

url=\
(
    "http://www.eu.apache.org/dist/ant/binaries/apache-ant-$version-bin.tar.bz2"
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
    cp -a ../apache-ant-$version/lib $cfg_dir_toolchain &&
    cp -a ../apache-ant-$version/etc $cfg_dir_toolchain &&
    cp -a ../apache-ant-$version/bin $cfg_dir_toolchain
}
