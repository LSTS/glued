version=\
(
    "2.5.35"
)

url=\
(
    "http://downloads.sourceforge.net/flex/flex-${version}.tar.bz2"
)

md5=\
(
    "10714e50cea54dc7a227e3eddcd44d57"
)

configure()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain
    ./configure \
        --prefix="${cfg_dir_output_toolchain}" \
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
    tar -czf ../flex-v$version-host.tar.gz ../toolchain
}
