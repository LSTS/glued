version=\
(
    '112'
)

url=\
(
    "https://lz4.googlecode.com/files/lz4-r$version.tar.gz"
)

md5=\
(
    'f4bf7806d6a9fd2db428febf6861b94d'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    cd "../lz4-r$version" &&
    $cmd_make
}

host_install()
{
    $cmd_mkdir "$cfg_dir_toolchain/bin"
    cd "../lz4-r$version" &&
    cp -v programs/{lz4,lz4c} "$cfg_dir_toolchain/bin"
}
