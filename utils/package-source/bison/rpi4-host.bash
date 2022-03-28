version=\
(
    '2.5.1'
)

url=\
(
    "http://ftp.gnu.org/gnu/bison/bison-$version.tar.gz"
)

md5=\
(
    '8fedf916f1aa2c4a31441d8f8bbc603c'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

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

    tar -czf ../bison-v$version.tar.gz ../toolchain
}
