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
    patches=$(ls "$pkg_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cd "../m4-$version" && cat $patches | patch -p1
    fi
}

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    ./configure \
        --prefix="$cfg_dir_output_toolchain" \
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

    tar -czf ../m4-v$version.tar.gz ../toolchain
}
