version=\
(
    '2.0.2'
)

url=\
(
    "https://hisham.hm/htop/releases/$version/htop-$version.tar.gz"
)

md5=\
(
    '7d354d904bad591a931ad57e99fea84a'
)

maintainer=\
(
    'Jose Pinto <zepinto@lsts.pt>'
)

build()
{
    $cmd_make
}

configure()
{
    cd "../htop-$version"
    ./configure --disable-unicode --prefix="${cfg_dir_rootfs}"
}

target_install()
{
    cd "../htop-$version"
    $cmd_make install
}

