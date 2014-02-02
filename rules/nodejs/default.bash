version=\
(
    '0.10.18'
)

url=\
(
    "http://nodejs.org/dist/v$version/node-v$version.tar.gz"
)

md5=\
(
    '8b905b6013b82fb7076b02a6c881f9a6'
)

maintainer=\
(
    'Jose Pinto <zepinto@fe.up.pt>'
)

configure()
{
    "../node-v$version/configure" --without-snapshot --prefix="${cfg_dir_rootfs}"
}

build()
{
    cd "../node-v$version"
    $cmd_make
}

target_install()
{
    cd "../node-v$version"
    $cmd_make install
}


