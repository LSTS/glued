version=\
(
    '1.9.2'
)

url=\
(
    "http://www.eu.apache.org/dist/ant/binaries/apache-ant-$version-bin.tar.bz2"
)

md5=\
(
    '20c6dc8e57d5dc8af595ec4faefd515c'
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
