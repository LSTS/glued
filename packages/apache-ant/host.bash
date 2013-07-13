version=\
(
    '1.9.1'
)

url=\
(
    "http://www.eu.apache.org/dist/ant/binaries/apache-ant-$version-bin.tar.bz2"
)

md5=\
(
    'a027cadf06422ebc8367632d93331beb'
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
