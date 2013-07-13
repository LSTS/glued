version=\
(
    '1.4.16'
)

url=\
(
    "http://ftp.gnu.org/gnu/m4/m4-$version.tar.bz2"
)

md5=\
(
    '8a7cef47fecab6272eb86a6be6363b2f'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cd "../m4-$version" && cat $patches | patch -p1
    fi
}

configure()
{
    ./configure \
        --prefix="$cfg_dir_toolchain" \
        --disable-shared \
        --enable-static
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
